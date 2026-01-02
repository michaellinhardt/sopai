#!/bin/bash

# Compression Metrics Tool
# Tracks file metrics before/after compression
# Stores snapshots in ~/.compression-metrics/ as JSON

set -e

METRICS_DIR="$HOME/.compression-metrics"
AGTS_DIR="./agts"

# Create metrics directory if needed
mkdir -p "$METRICS_DIR"
# AGTS_DIR created as needed when writing report

# Check arguments
if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: compression-metrics.sh <workflow-folder> <file-path>"
    echo "  workflow-folder: The workflow folder name (e.g., wkf.1767385361)"
    echo "  file-path: Path to the file being compressed"
    exit 1
fi

WORKFLOW_FOLDER="$1"
FILE_PATH="$2"

# Verify file exists
if [ ! -f "$FILE_PATH" ]; then
    echo "Error: File not found: $FILE_PATH"
    exit 1
fi

# Generate hash from file path for unique key
FILE_HASH=$(echo -n "$FILE_PATH" | md5 2>/dev/null || echo -n "$FILE_PATH" | md5sum | cut -d' ' -f1)
METRICS_FILE="$METRICS_DIR/${FILE_HASH}.json"

# Calculate metrics
FILE_SIZE=$(wc -c < "$FILE_PATH" | tr -d ' ')
CHAR_COUNT=$(wc -m < "$FILE_PATH" | tr -d ' ')
TOKEN_ESTIMATE=$((CHAR_COUNT / 4))
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
FILE_NAME=$(basename "$FILE_PATH")

# Create new snapshot
NEW_SNAPSHOT=$(cat <<EOF
{
  "file_path": "$FILE_PATH",
  "file_name": "$FILE_NAME",
  "timestamp": "$TIMESTAMP",
  "size_bytes": $FILE_SIZE,
  "char_count": $CHAR_COUNT,
  "token_estimate": $TOKEN_ESTIMATE
}
EOF
)

# Check if metrics file exists (has previous snapshots)
if [ -f "$METRICS_FILE" ]; then
    # Read existing snapshots
    EXISTING=$(cat "$METRICS_FILE")

    # Get the first snapshot (before) metrics
    BEFORE_SIZE=$(echo "$EXISTING" | grep -o '"size_bytes": [0-9]*' | head -1 | grep -o '[0-9]*')
    BEFORE_CHARS=$(echo "$EXISTING" | grep -o '"char_count": [0-9]*' | head -1 | grep -o '[0-9]*')
    BEFORE_TOKENS=$(echo "$EXISTING" | grep -o '"token_estimate": [0-9]*' | head -1 | grep -o '[0-9]*')

    # Append new snapshot to array
    UPDATED=$(echo "$EXISTING" | sed '$ s/]$/,/')
    echo "${UPDATED}
${NEW_SNAPSHOT}
]" > "$METRICS_FILE"

    # Calculate deltas
    DELTA_SIZE=$((FILE_SIZE - BEFORE_SIZE))
    DELTA_CHARS=$((CHAR_COUNT - BEFORE_CHARS))
    DELTA_TOKENS=$((TOKEN_ESTIMATE - BEFORE_TOKENS))

    # Calculate percentages (avoiding division by zero)
    if [ "$BEFORE_SIZE" -gt 0 ]; then
        PCT_SIZE=$(awk "BEGIN {printf \"%.1f\", ($DELTA_SIZE / $BEFORE_SIZE) * 100}")
    else
        PCT_SIZE="0.0"
    fi

    if [ "$BEFORE_CHARS" -gt 0 ]; then
        PCT_CHARS=$(awk "BEGIN {printf \"%.1f\", ($DELTA_CHARS / $BEFORE_CHARS) * 100}")
    else
        PCT_CHARS="0.0"
    fi

    if [ "$BEFORE_TOKENS" -gt 0 ]; then
        PCT_TOKENS=$(awk "BEGIN {printf \"%.1f\", ($DELTA_TOKENS / $BEFORE_TOKENS) * 100}")
    else
        PCT_TOKENS="0.0"
    fi

    # Output comparison table
    echo ""
    echo "## Compression Metrics: $FILE_NAME"
    echo ""
    echo "| Metric       | Before    | After     | Delta     | % Change |"
    echo "|--------------|-----------|-----------|-----------|----------|"
    printf "| Size (B)     | %-9s | %-9s | %-9s | %s%% |\n" "$BEFORE_SIZE" "$FILE_SIZE" "$DELTA_SIZE" "$PCT_SIZE"
    printf "| Characters   | %-9s | %-9s | %-9s | %s%% |\n" "$BEFORE_CHARS" "$CHAR_COUNT" "$DELTA_CHARS" "$PCT_CHARS"
    printf "| Tokens (est) | %-9s | %-9s | %-9s | %s%% |\n" "$BEFORE_TOKENS" "$TOKEN_ESTIMATE" "$DELTA_TOKENS" "$PCT_TOKENS"
    echo ""

    # Save compression report
    REPORT_DIR="$AGTS_DIR/$WORKFLOW_FOLDER"
    mkdir -p "$REPORT_DIR"
    REPORT_FILE="$REPORT_DIR/${FILE_NAME}.compression.md"
    cat > "$REPORT_FILE" <<REPORT
# Compression Report: $FILE_NAME

**File:** \`$FILE_PATH\`
**Generated:** $TIMESTAMP

## Metrics Comparison

| Metric       | Before    | After     | Delta     | % Change |
|--------------|-----------|-----------|-----------|----------|
| Size (B)     | $BEFORE_SIZE | $FILE_SIZE | $DELTA_SIZE | ${PCT_SIZE}% |
| Characters   | $BEFORE_CHARS | $CHAR_COUNT | $DELTA_CHARS | ${PCT_CHARS}% |
| Tokens (est) | $BEFORE_TOKENS | $TOKEN_ESTIMATE | $DELTA_TOKENS | ${PCT_TOKENS}% |

## Summary

- **Size reduction:** ${PCT_SIZE}%
- **Token reduction:** ${PCT_TOKENS}%
REPORT

    echo "Report saved to: $REPORT_FILE"

else
    # First snapshot - create new file
    echo "[
${NEW_SNAPSHOT}
]" > "$METRICS_FILE"

    echo ""
    echo "## Compression Metrics: $FILE_NAME (Initial Snapshot)"
    echo ""
    echo "| Metric       | Value     |"
    echo "|--------------|-----------|"
    printf "| Size (B)     | %-9s |\n" "$FILE_SIZE"
    printf "| Characters   | %-9s |\n" "$CHAR_COUNT"
    printf "| Tokens (est) | %-9s |\n" "$TOKEN_ESTIMATE"
    echo ""
    echo "Snapshot recorded. Run again after compression for comparison."
fi
