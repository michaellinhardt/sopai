

Transcript
Ralph Loops + AGI: coming out of the cave
0:01
Okay, so today I want to talk about Ralph Loops and AGI. So basically the state of the art. I've been in my cave
0:07
for about seven days now and this is like I'm coming out. I need to like I need to push this information out so I
0:13
can be a Zen Buddhist again and focus. So what is what am I talking about? So
How software gets built now: idea.md → Ralph → specs → loop
0:18
how do we do software engineering? I'm going to tell you how you're supposed to do it. So you write idea in a markdown
0:24
document and then you link this directory called Ralph which is this framework and then it just generates
0:30
specs and runs a loop. So what is the fastest way to generate value? So right
5 levels of leverage: manual → autocomplete → agents → role-programs → “thought-to-reality”
0:35
now used to be basically a team of engineers right the code manually. Then level two we
0:42
want to augmentation. So now we use like auto completion whatever and uh you know
0:47
cursor clawed whatever we used to we used to just tab it out and now we're getting to level three. Level three is
0:53
like delegated labor. We're using these agents to build features. I don't know if anyone's doing this yet. This is a kind of new thing but basically you
0:59
orchestrate and you supervise the agents. Level four we like start building like prompts for actual like
1:06
roles that would typically be an employee in a company like marketing, sales, whatever. We're actually using
1:12
like AIS to like run these programs which represent these people's roles and
1:18
the loops will like self-improve and self iterate. And then level five, level five, we just think of ideas and then
1:23
like agents start building them. This is this is the [ __ ] is like you're going to have neural link. It's going to be in your brain. You're going to be like [ __ ]
1:30
I'm thirsty right now. And then beer is going to appear like in your hand. It's just going to be there and you're like
1:36
what the [ __ ] And then as you're thinking, as you're visualizing this beer, as you're seeing this great
1:41
northern, you re you're having this disgust reaction because you're actually in the south. You're in Victoria. And
1:46
then it's immediately actually going to redesign the beer and it's going to replace it in your hand. It's going to be like a cool Victorian warm ale or a
1:55
warm winebased thing rather than a cold ass [ __ ] northern Queensland, you know, ale. And this is what's going to
2:01
happen. This is what's going to happen. So like, let's think about it. I just wanted to I I made this table because this is easier, right? So, you start off
Bottleneck ladder: each breakthrough shifts the constraint
2:09
level one. I always think of this in terms of bottlenecks. I think in terms of like the gist of where we're at, the
2:14
state of the art, the innovation which unlocks something, and then the new bottleneck. So, we start off with like,
L1→L3 recap: copy/paste → context copilots → tool-using agents
2:19
okay, humans typed code, right? And state of the art was like AI didn't exist. And then they figured out how to
2:25
like basically tune an AI to be an assistant rather than this sort of thing which just like predicts probabilities.
2:31
And then all of a sudden AI could generate code solutions. And so the bottleneck is like well how quickly could I copy paste these solutions. The
2:38
second level was like okay now we're like generating code and copy pasting and state of the arts chbt and the
2:45
innovation was like context. It's like okay I could suddenly get an AI to uh
2:51
actually be alongside me in the codebase. And so now my bottleneck is actually just hitting tab on my computer
2:57
and navigating around the files as I'm like building these features, right? So that was pretty cool. And now we're like
3:04
autocompleting code. That's this that's the gist of what we're doing. State of the art is co-pilot. And then boom, we
3:10
figured out how to give AI tools. So now they're not just like autocompleting, but they're actually like doing their
3:15
own stuff in the codebase. They're listing, they're like editing files, they're running build commands. And you're like, "Wow, that's pretty cool.
3:22
how fast can I build features now? Um it's bottlenecks by like how quickly I
3:27
can translate my intent um into like basically prompts I'm giving Claude. I'm
3:32
saying like okay this is this feature here um like build it and Claude's like
3:37
okay yeah I got enough information I can do ls I can generate code I can like compile. So that's all cool. What I'm
Why agents matter: multi-tab supervision vs real autonomy
3:44
going to talk to you today about is like agents. The the trick with agents is that like humans they're already like
3:51
managing like you know the state of the art is like some people are out there and they got seven tabs open and each
3:57
tab is clawed code and the claw code is working on tasks right um that's the
4:04
state of the art and the the innovation today I want to talk about is like loops and specifically this thing called Ralph
The Ralph unlock: sleep 8–12h, wake up to progress
4:10
and like what Ralph does is like basically Ralph's unlock is that like AI can build on autopilot and the way to
4:16
just think about it is just like you type into your computer some [ __ ] and you go to sleep and 12 hours later you
4:25
come back and your computer has like built stuff but it hasn't like gotten
4:30
stuck anywhere. It's continued working out stuff and that's what you can't do with Claude right now. You actually have
4:36
to come back, you know, at least every 30 minutes. Maybe there's someone out there who's figured it out. They can get
4:42
it to run autonomously for 30 minutes, but at least every 30 minutes. And now you can get it to run for like eight
4:48
hours, nine hours. Um, and that's that's crazy because the new bottleneck then is
4:53
like, well, how quickly can I like, you know, pump stuff into this loop that
5:00
seems to be reliable enough to build features. Um, so I'm going to talk about the loop because now we're going to
What is a loop: Kubernetes-style “drive current state to desired state”
5:05
understand why it works and why it won't work. So like what is a loop? And basically it's like Kubernetes. So
5:12
Kubernetes start off with this idea which is like okay how do we continuously drive the current state of
5:19
the system which in Kubernetes was like infrastructure but in our example it's it's it's an application right which is
5:27
source code and so how do we continuously drive the source code into its desire our our desired state and our
5:34
desired state is made up of specifications of markdown files right so it looks like this it looks it looks
The 4 artifacts: idea, specs, plan, loop-build
5:42
like four pretty simple things. It goes idea, specs, plan,
5:47
and then this loop which which builds. Um, so I'm going to like run through a
5:52
simple example, right? So let's talk about this presentation today. I know it's pretty chaotic presentation. Let's talk about the presentation. Right? So I
5:59
start off and I go, okay, nano idea.mmd and I start writing. So I'm like, all right, I'm going to give a presentation to the OS builders about Ralph whatever.
Example workflow: writing idea.md + feeding prompts
6:06
I paste 20,000 lines from the Ralph repo. I paste 20,000 lines from like Steve Jobs the art of prisoning. I go,
6:12
"Okay, what's all those build is like?" And then I accidentally paste the other deal by accident. Boom. Next step, I go
6:19
to Claude and I go, "Okay, Claude, um, at like this prompt which generates
6:24
these specs and then at the idea file." And then Claude spends a minute and he's
6:29
like, "Okay, bam." And then he writes these specs. What do these specs looks like? Well, the point of the spec is
What “specs” are: the ideal target state in files
6:35
like basically the ideal state. So, the spec might be, okay, the presentation is
6:40
engaging, funny, and visual. Um, it's in English, it's like short, and it's
6:46
pretty fast. And then also, we don't give a [ __ ] if it's like not safe for work. Like, it's just going to be it's
6:51
it's going to be funny. Um, the other spec is like, okay, what's actually in it? Um, well, it's about software
6:58
engineering and Ralph. And the thing is that Claude is going to write these files and Claude's going to write something really good. Like, it's going
7:04
to be stellar. like way and way better than if I was to like write it by hand.
7:09
It's going to like really think about all this sort of stuff. And that's the key is that the agents or the AI is
7:15
actually has this latent intelligence um where it can actually think of the
7:21
complete picture. It doesn't require you to know the full picture. It can actually think of the complete picture.
7:27
And that's all based on the prompt that you use this sort of this this prompt requirements um generate requirements.
7:33
And so from that it's got these specs and then we just call Claude again. We go okay now plan um and plan knows to
What “plan” is: sprint-like to-do list + dependencies
7:42
scan these spec directories and it starts up a bunch of agents like 500 sub agents and then it will just generate a
7:50
plan. And what is a what is a plan? I mean a plan is pretty simple actually. It's just a to-do list. Um but the
7:57
claude's going to think of it and it's going to think of it in terms of like it's pretty much the same as sprint planning. It's going to be like, okay,
8:02
we're going to divide the work up into like a bunch of different like chunks here, and we're going to schedule it. So, we're going to do the the things
8:09
which unlock the other things first. We're going to understand the dependencies, and then we're just going to like write a to-do list. Um, and the
8:15
to-do list doesn't have to be concrete, but it's concrete enough that it's like, okay, the agent's not going to get stuck
8:22
like doing deep R&D. It's going to know, okay, yeah, I just have to make some slides. I have to like flesh out some
8:27
stuff. And yeah, and so it might look like this, you know, might start off being like, okay, ideation. So we take
8:34
these Dexis, going to turn on turn on photo booth. We're just going to start [ __ ] just just just just pumping out
8:41
B2B SAS concepts, you know? Then we're going to write these into bullet points. And then we're going to like go, "All
8:46
right, there's the slide deck." And then stage two. Stage two, we're going to create the slides, going to slap in some
8:52
graphics, and then bam, we got a [ __ ] presentation. Stage three, we present. Okay, so the key bit is we've we've
The “loop” run: iterate, tick plan items, keep going
8:59
gotten to this point where like, okay, we're going we've we've interacted with Claude and we've been at the computer
9:05
the entire time basically like we couldn't have like gotten Claude to automatically do all this. We were at
9:11
the computer typing. And this is the interesting part because now now we're
9:16
actually looking at it and we're going we're gonna just run this command and it's going to be called loop. And what
9:22
that's going to do is it's just going to iterate. And each iteration it's going to like you're just going to check the
9:28
plan and it's going to ticked off a bunch of stuff in the plan. So iteration one, bam. Iteration two, bam. Iteration
9:35
three, bam. How the [ __ ] does it do this? Well, basically this is what it the code is really simple. All it does
The whole secret: while true + one big prompt
9:41
is it just loops while true and then it just pipes in this prompt into claude.
9:47
So the prompt's doing all the work. What is the prompt? Well, the prompt is pretty simple. Conceptually, it's like
9:53
before you do anything, read all the specs, read the plan, and then read the code.
Loop prompt anatomy: read specs/plan/code → implement → test → update plan → commit
10:00
And all we're going to do is we're going to pick one item. We're going to search through the code, get up to scratch, and
10:05
we're going to implement it. We're going to run tests. We're going to fix gaps, right? We're going to update the plan
10:12
with anything we notice. And then if all the tests pass, we just commit and we we push it. And then we're done.
10:20
And this might seem like, okay, is is this like are we giving each step at at
10:25
a time like and then we're checking? No, we're giving the whole prompt because this is enough. This is actually the the
10:31
models are pretty smart. They can go, okay, there's only four steps here. and I can figure out what I'm doing um
10:39
from just these four steps. Um and and what we do is we just run this in a loop
10:44
and this actually works. That's the crazy thing. This actually works. Um you
10:50
can run this and and and you can basically do exactly what I've just said
Overnight demo: to-do app built + deployed (until tokens crashed)
10:56
and it will build software for you. I mean I did this overnight. I ran like a loop. I, you know, start off on my, hey,
11:03
make a to-do list app and then I generated some specs, right? And then from the specs, I generated a plan and I
11:09
ran loop and overnight it crashed because I ran out of claw tokens. And then the next night I ran it and I woke
11:17
up in the morning and I had this to-do list app and it had done all this stuff and it deployed it and it run it and
11:24
this is all possible today which is [ __ ] incredible. So
Mapping the definition: continuously/drive/current/towards/desired ↔ loop/prompt/source/plan/specs
11:30
what what why am I telling you this? Because you you know who cares about to-do list apps. Well, I mean this is
11:36
interesting already because okay now you can automate a substantial part of your
11:42
work. But like what's interesting more so for me is that just like this idea of the loop isn't actually it doesn't
11:49
actually end there. So like going back to the original definition, we're going to continuously drive the current state
11:55
towards a desired state. And then let's just map this onto what we're talking about. So continuously means loop.sh.
12:03
Drive means prompt for this build loop. Um the current state is source. Towards
12:10
is just the plan because we keep track of our plan. And the desired state is what we got in
12:16
specs. So, you know, when we when this loop crashes, what's interesting about
Idempotence: restart after crash, re-read state, continue
12:21
it is it's item potent, meaning it like can start up again and like just work
12:26
like just figure out it figure it doesn't get corrupted. So, when the loop
12:32
crashes, it you just restart loop. It rereads that prompt. It studies the
12:37
current state. It studies the plan and it studies where we're going. And then it just picks an item off the plan and
12:46
it uses its intelligence. It's studied all what's current and then it just continues working and it's just it just
12:53
continues doing that. And that's [ __ ] amazing actually. Um because what that means is you can actually add things to
Live evolution: edit specs/plan mid-run and it adapts
13:00
the specs as as you're building and you can add things to the plan as you're building
13:07
and the loop just runs in this terminal and every time it start up with a new iteration all the time it's starting
13:15
this new iteration after it finishes the previous one starts a new one and it just reads the state from the system and
13:21
if you added anything to the state if you've added new items to the plan if you've added new specs It just picks it up automatically. Um,
13:29
which is crazy. So, what's crazy about this? Well, who [ __ ] cares? Well, I
13:34
do care. And I'm going to tell you why I care. Because the loop doesn't just have to dev, does it?
Beyond feature dev: “loops” as a general pattern
13:41
I mean, I started off with this project and I was building something and um and
13:49
I was building features and uh it was like a markdown editor and I was like, "Okay, I want you to just like build out
13:55
sort of like some like from this spec." I had a document. I'm like, "I want to do all these things and then it
14:01
translate that into specs and it's working on these specs and then of course like um you know I originally
14:07
started this as like a hacky sort of claw project. I was doing it manually and I got ahead of myself and you know
14:13
it has a bunch of bugs because of the engine and I was like okay well it's building this stuff but I wonder if it
14:19
can just like fix the bugs as well. Um and I was like well wait a minute this
Bug-fix loop: reproduce via unit test → root cause → fix → verify
14:25
bugs like and I was like going to write these documents and I realized I'm like well this bug thing is just a loop as
14:32
well. So, you know, like it's a different type of loop though cuz it's
14:37
not there's no specification for a bug. It's more like I want you to reproduce the bug and then dive in and like try to
14:46
fix it. Um, and the reproduction is like you write a unit test to reproduce the
14:51
bug and then once you've got the unit test written then you can like run the test and then you can sort of hatch a
14:56
plan to like identify the root cause, implement the fixes, verify by the test
15:02
and if the test passes then you fixed it and if it doesn't pass then you haven't fixed it. And so I was like, okay, I'll
15:09
just write a prompt for this. And this prompt is like prompt, but instead of
15:14
loop build, it's loop bug fix. Um, and the loop now looks like continuously
15:20
drive where the drive is actually a bug fixing loop. The current state towards the desired state. And the desired state
15:28
is now well, there are no more bugs in the bugs folder. They're all resolved.
15:34
And um and this works. This also works. And I started thinking I'm like, damn,
15:39
if that works, what what else what else could be a loop? Um, you know, I started
15:45
going, well, I fall asleep and the bug fix loop crashes because I've run out of
15:50
tokens or it crashes because it gets into its own loops where it can't break out because it's um, you know, the
15:58
architecture is too messy right now and it's uh, it it's very it's very much focused on fixing bugs, but then it
16:05
might fix one bug and then go to fix another one and then it does it a sort of hacky way. And so I realized I'm
16:11
like, well, I could just run this loop inside Claude and let Claude supervise
Meta-loop: Claude supervising the bug loop (looping the looper)
16:16
the loop. So Claude's like looking at it looping and going, "Oh, well, I can see that
16:23
it's like making this dumbass sort of error of just like fixing these things which aren't actually the cause." And so
16:29
you can do that. You can actually do that. And it kind of like can work. I mean, I'm not going to claim I'm a
16:35
professional at this, but it's also like, well, how smart is the model? If the model can
16:41
build the application, the model can probably solve whatever stupid stuff it's doing. And so, I start thinking
16:50
like what else could the model be capable of? What what else is like what really is intelligent here? So, could we
Can we loop marketing: changelog → briefs → ideas → content → publish → feedback
16:56
for example loop marketing? I mean, you know,
17:03
marketing nowadays is probably making like a bunch of Tik Tok brain roll videos, right? But then you think about
17:08
it, you're like, well, I've got a change log. I've got all the stuff. It's completed. And what is marketing? It's
17:14
like letting making people aware that, you know, you're having this solution out here and it's it's it's improving.
17:21
Well, maybe we could we could automate that. Maybe what would that look like? Um, okay. Well, so read the change look.
17:30
um create some briefs, right? You just say, "Okay, this is like the creative thing we want to we want to sell." And
17:37
so it'll make a bunch of briefs. Um this is the what we need to do. And then like
17:43
loop on generating some ideas maybe, right? And we'll say, "Okay, the the ideas need just keep looping until some
17:50
criterion is met, like I don't know, the idea is good enough um according to an
17:56
audience or whatever." Um, and then we'll generate Tik Toks for all those ideas and then we'll schedule and we'll
18:03
publish those Tik Toks and then we'll measure the engagement and we'll store the feedback in this folder feedback and
18:10
we'll like you know we'll have this. Now all of these steps you can kind of automate um just like the process we
18:18
already went through. It went from idea to uh requirements and generation of
18:23
specification and then from the specification we analyze it and we create a plan and then from the plan we
18:29
iterate in uh a build loop on like implementing each part of the plan and
18:35
you know that's like there's some serial steps there. we go A B C and then the final bit is kind of parallel or it's
18:41
not parallel but there's a loop and we go while blah just popping stuff off from that that plan and finishing it and
18:48
marketing could probably be the same thing I mean I don't know but it's not that much different of a task is it I
18:55
mean it's still you're generating stuff you're thinking um and you require
19:01
intelligence and we have intelligence so you know we read the change log we
19:06
create all this stuff and Then we like store the feedback.
19:11
And then what if and then the humans manually analyze the
Feedback analysis loop: model extracts rules/taste signals into a knowledge file
19:18
feedback? Are you smoking crack? Are you [ __ ] smoking crack right now? What? What are you talking about? What? Hey,
19:24
what do you mean analyze the feedback? What? Not no. We use Claude to do that
19:30
as well. Obviously, you know, obviously we just go, "Hey, chat GBT. um this
19:37
video where I intentionally spark rage at my viewers because of some political topic of the day here and then we have two only fans model and they're jiggling
19:43
their text. Oh, why does this work? I don't understand. How does this work better than uh the video where I'm just
19:49
uh it's a LinkedIn seminar and chatb is going to be like oh obviously um sex
19:55
sells and people want to feel angry adding this to agents MD and what that
20:00
means is that like basically it's just going to learn. It's going to go, "Oh, I'm gonna add it to a markdown file."
20:06
And then the next time we do this loop of marketing, I'm gonna remember that like, "Oh, wow. People actually are like
20:12
really engaged by like shitty brain wrong content." And that's actually maybe like it's actually improving the
20:18
marketing. It's it's getting us views. And so that's what's going to happen.
Taste as the scarce input; production becomes commodity
20:23
It's 2026. We can do that. That's it's not outside the realm of possibility
20:29
that a model can actually look at like the what you've built and like what
20:34
you've put out there and think about it and analyze it. I mean, it's not
20:40
actually that hard at the end of the day. You know, what's hard is taste. What's hard is like a lot of other
20:46
people are doing this. So, you're going to have to think of like ways to put your taste into this process. But the
20:52
actual work of like generating a video, you know, like the the key valuable thing, the oil that you're giving the
20:58
model is actually the the the taste of like what's what's current. Um
21:05
is it's just these these speckles of just like concept and then the rest of it is just commodity. It's just, you
21:12
know, generating a video, that's easy. Putting in like actors or whatever, that's easy. um putting in like
21:18
voiceovers, putting in like speeches, you know, audio, all that stuff can just be generated. Even just the process of
21:24
generating it can be generated. Like it's not that hard to make code which makes videos now. And it's not that hard
21:31
to even just like make things which make code which make videos. Um it's all
21:36
about like orchestration. You know, it's 2026. Like get with the program. This AI
“If it cloned an OS, it can learn marketing”: capability argument
21:42
cloned an entire operating script system from scratch. Like from [ __ ] scratch.
21:47
It took pictures of Mac OS, like an old version of Mac OS, and it just cloned
21:53
it. It cloned it. You know, if you think that like marketing is more complex than building an operating system. I mean,
21:59
you're wrong because there's the the half of this was like just looking at
22:05
pictures and implementing functionality and, you know, building parts and like
22:11
that's the thing. It's like marketing is going to be there are aspects to marketing which are complicated but like
22:16
marketers get paid less than the people who have built this operating system in
22:21
many cases. Um, and even if they get paid more, the point is is that like we
22:27
have models which are intelligent now. It can do something as as complicated as this. It can probably do something as
22:32
complicated as marketing and learn from it. Um, my computer literally built me a
Example capability leap: RL creatures learn to walk + see + predator/prey dynamics
22:38
[ __ ] neural network which taught like geometric 3D models how to walk. And then not only that, but then it also I I
22:45
asked it after that. I'm like, well, can you like give the models vision? Can they like perceive other models in the
22:50
game? and it gave him eyes. And then I said, "Well, if it can do that, can you like build neural networks for each one
22:57
of these things?" And so it learns. And then it basically said, "Okay, I'm going to like make half of them predators and
23:03
half of them prey." The predators, they learn to like hunt and chase the prey. And then the prey, they learn to like
23:09
run away. And they learned a model of like the predators like dynamics in terms of like how they hunt. And then it
23:15
trained it. And then it did it. And that's [ __ ] it just did. It just did that. All I had to do was steer it. I mean, we live literally in the future.
23:23
Like, you know, I was never that good at mathematics. I'm pretty all right, but I
23:29
never really wanted to practice it that deeply. And now I don't actually have to. Um, to build 80% of the ideas that I
23:35
have, I can just ask Claude to do it. I can use the right language and it will do it and I can steer the model. And
23:42
sure, if there's like, you know, fundamental research to be made, yeah, I don't have the the talents to do that.
23:48
Um, but that that's not what I ever really wanted to do. I I only was learning that like the computer is now
23:55
doing the magic for me. And that's that's incredible. Um, we probably don't even understand. I mean, this is just
24:01
based on what I understand, but I don't actually understand, you know, because if I look at it, you know, 5 years ago,
5-year compression: manual → tab → paste → agents-overnight
24:07
I was writing code by hand. Like I was literally and I can't even remember how
24:13
simple that used to be because it just seems so like today you know like today
24:19
I literally go to sleep and when I wake up my guys have made some software like
24:24
that's [ __ ] wild. One year ago I was using Claude and I was getting it to write files. Two years ago I didn't even
24:31
have Claude. I was like still copy pasting and it was from 01 and I was impressed that it was like something
24:36
complicated like a consensus algorithm but I was still copy pasting. 3 years ago I was just tabbing. Four years ago I
24:44
was only at the stage of copy pasting. Um and it was like snippets of code and
24:49
now we have something that's like automatically building it while I sleep. And then you think about it and you're
24:54
like well okay what you know what are we in the future? It's like, oh, can an
25:00
agent do marketing? It's like, [ __ ] hell. Look at what's happened. Look at the past 5 years. I mean, could it do
25:06
marketing? I I mean, it just it just cloned an operating system and it half
25:12
works. We're talking about an operating system. These things that have existed for like
25:17
20 years and have been iterated on, it half works. And this wasn't possible a
25:23
year ago and now it's possible. I mean at the end of like 2026 we are probably
25:29
going to look at this and we go man how could I not see the future coming like
25:34
just based on what's been happening how could I how could I not see that it like
25:40
all the data points were there um and so yeah let me give you a metaphor right so
7T metaphor + speed/cost curves: 3 months → 1 day → 30 seconds
25:46
$7 trillion that's what Sam wanted to raise I put it to you that that maybe was reasonable I mean the GDP growth
25:52
from 1975 to85 was 7 trillion And then you think about like how long
25:58
did it take you to build that SAS app in 2020? How long does it take it to build it
26:03
now, right? And then how long will it take to build it in 5 years time? And
26:09
right now, you know, might take you like, I don't know, a day or so. But in
26:14
2020, it would have taken you like, I don't know, 3 months to build something, you know, of moderate complexity maybe.
26:19
Um and then in like 5 years it might genuinely take like 30 seconds. Um like
26:26
genuinely it might just be we have so much improvement in the speed in like
26:33
the frameworks might take like 30 seconds and then if you think about that go back to 2020
26:40
if you had access to that because keep in mind the cost goes down and the speed goes up and they're independent
26:47
variables. So if you had access to this technology back then that could like you
26:54
could sell you could build these products and sell them and you could do it literally two and a half million
27:02
times faster and at like pennies. You know how much money could you have made
27:07
in that year as a contractor if you just had access to that technology? And
27:13
that's kind of like similar to how much did GDP increase between those that 10
27:20
those that 10 year gap. That's just for one person. But multiply that out by everyone, right? That's just that's
27:27
that's you know $7 trillion. I don't know how much money could you make probably a lot. Um
Multi-loop stack: spec loop, build loop, test/bug loop, marketing loop, ideation loop
27:35
anyways, so you know what how do you do software engineering now? You basically just keep asking what's the bottleneck?
27:41
You just keep going. Well, you know, what can be made parallel? What's the best bang for buck in terms of like
27:47
tokens to value delivered? Um, because you only get 20 million tokens a week. Um, and you just start thinking, you
27:55
start thinking about these things. You go, well, as the build loop is running, another loop is producing specs to
28:00
build. And as the bug fix loop is running, another loop is studying the
28:06
program interactions and testing it to find bugs. And when they find them adding bugs to this bug fix queue and as
28:12
this software engineer loop is running, another loop is running to market features on Tik Tok and shorts. And as
28:20
the marketing loop is running, another loop is running to study the world and like ideulate on new product capabilities. I mean keep in mind you
28:26
have Twitter and all these things are announced by Twitter. um all these new models and every model has you know
28:34
latent capability to do things with your product that you hadn't thought of before like generate speech or like you
28:40
know generate features or do different things like this. Um and you don't need
28:45
to be looking at those tweets. You actually can have an agent looking at them for you and then you can have another agent that's like generating
28:51
ideas and then something that's taking those ideas and translating them to like product specs and then actually building
28:57
them and then another thing which is like actually taking the change log of things that are being built and then
29:02
actually like building marketing videos. And this entire thing is like loops on loops on loops. And you can do this with
29:09
your computer. You don't actually have to hire people necessarily. You could probably and possibly do it with your
29:14
computer. If you can't do it now, you can probably do it in 12 months or in 24 months because everything is actually
29:20
moving. It's in real time. And as you're doing this, you know, you're realizing that like the valuable the the the
29:27
scarce resource you have is actually like talking to the computer. I mean,
29:32
it's all right now it's orchestrating these loops. But in a couple years, the scarce thing is actually just talking.
29:38
It's just talking and the computer is like listening. And as it's listening,
29:44
it's getting cheaper and cheaper to prototype these thoughts you have. And it's reading your intent better. And
29:50
it's going to be as you're talking that it's actually going to be like realizing
29:55
prototypes and like thousands of these at once. And it will be like presenting them to you at the end of your talking.
30:02
Um, and you'll just look at them and it will like realize what you think is maybe a preference or you know. And um
30:10
but yeah, right now it's just right now it's just this dude with like seven agents open and then another guy who's
30:16
one step ahead and he's like looping. Um but it goes so much further. Um the
30:24
bottleneck though is like, okay, where does where does the loop fail? Um and
30:30
you know, it's it's like that's what we're figuring out, but there's like a long trajectory of like, damn, this [ __ ]
30:36
goes really fast. Um, so you know, we might be like L3, we're delegating
30:41
labor, but L4 it's like we're designing workers. Um, we're orchestrating them and we're just providing intent. And L5
30:48
is like extended imagination. You know, you just think of ideas and like AI pop up and do stuff. But anyways, so you
Staying sane: your job becomes “solve the bottleneck of the loops”
30:54
know, there's a bunch of questions like what happens to work? Um, and then there's like just tactics for staying
31:01
sane. I mean, what do you how do you stay sane when [ __ ] changes like this? Well, you just go like my responsibility
31:07
is to solve problems and you know before I solved problems of there not being
31:14
code for features and now I solve problems of like okay the agents don't
31:19
have the specifications yet. Um so they're just running on an empty loop. So now I'm the guy who solves the
31:25
problem of like how do I get the specifications faster? Um and to do this I just learn the tools to solve
31:32
problems. And the the key thing is that like you know you don't like things are
31:37
going to change faster than you actually have time to catch up. And that's okay because you just need to like catch up
31:45
every once a month and you just look at what the best thing is there and you just update your approach. Um because
31:52
you still got to be doing stuff. It's still going to be working and generating value but just you just update your approach as it comes. Um because at the
32:00
end of the day, you know, you're steering a loop. You're steering like
32:05
tools. And like before it was like, okay, now I got to buy a new MacBook every 5 years. And now it's just like,
32:12
okay, now I got to write like a better orchestration for something to generate to do the job. Um and like I think the
Distribution/moat: audience + community as discovery layer
32:20
biggest tactic to staying sane is like you know one like being part of a
32:26
company and having a job or just starting a startup but like being part of something cuz like in this age like
32:33
the attention is scarce but the like the the distribution is where you need to
32:38
be. You need to be there going to be like a billion different voice recording apps for Mac and people aren't going to
32:44
like find them easily. So, they're going to just look to like wherever who's
32:49
who's the guy I go to to tell me what the app is or where's the community where people know their [ __ ] and that's
32:56
where the app is. Um, but in in amongst this, you're still going to be competing against everyone
33:02
else because there, you know, everything's going to be getting automated. And the best way to really like the best moat really for this is
33:08
like not to like hold on to ideas because like ideas of how the world work
33:13
faster than you can like actually absorb the new way the world works because to
33:19
to update those ideas you're going to be need to be going like where do I find the information for this? It's just
33:24
going to be tiring. So what you do is you hold on to questions because the questions give you the frame and the
Moat reframed: hold questions, not beliefs; answers update monthly
33:30
question might be it's like well okay what's the bottleneck in what I'm doing right now? Um or like how can I get this
33:37
done faster? And that question is always going to stay the same. Um the answer is
33:42
going to change but the question is always going to stay the same. And so you can you can you can hold a bit of
33:48
like mental peace and clarity by going I just have to be refining my question
33:53
asking ability. I don't have to be up refining ideas because basically whenever I reenter this mode of personal
34:00
development, I am going to have the same question. The answer is always going to be different because things are getting
34:06
better. Um, but that's good because then I'll just record the answer every time. I'm not always trying to look at my
34:12
current answer and go, "Fuck, how do I update this?" I'm just looking at like my current question and what I had as
34:18
the answer last month and I'm just updating that answer. And that's how you operate. that's that's going to be the
34:24
most peaceful way of operating. Um, you know, the question I'm asking right now is like can the model automate this and
Reliability limits: codebase architecture, refactor-first loops, model upgrades
34:32
at what point does it stop being able to do that reliably? Um, and when does that point change, you
34:39
know, and then you start thinking about it and you're like, well, can the autom can the model automate,
34:46
you know, building features for me? And the answer is yes. At what point does
34:51
that stop being reliable? Well, depends on your codebase, depends how you know
34:57
good architecture is. And um at what point does that change? Well, you know,
35:03
it changes when either one the model can like come back
35:08
to you and tell you that it can't do the job or two maybe when you build like a
35:14
loop that does the refactoring work before it does the feature work. And you know, maybe that changes. Um but the
35:21
point is is that like if you just write down those questions and then you come back 6 months later uh you can just ask
35:28
the question again and then you be like oh well the new model's come out and it can actually solve this and then you go
35:35
okay cool I'll just ask the question again now that I'm like this can be automated what's the next level up
35:41
what's interesting about the question though is that the question can also be run by an AI so technically speaking you
35:48
don't even have to do that work you can actually just get an AI to be asking these questions for you. You just write them down in a little area of your
35:53
computer, but whatever. That's maybe like a level too far. Um, so yeah, I mean, this is like this is my
36:00
presentation. Um, you know, it's like what happens to work? Well, we're just going to speedrun all the questions
Rapid-fire implications: work, policy, construction, data centralization
36:06
like, whoa, the AI can work autonomously. Well, it works while I'm asleep. Oh, it's kind of like investing.
36:11
Oh my god. Um, it's like, oh wow, I can make my own agents for different domains. Huh, that's it. That's it. Oh,
36:18
I can automate the work of of of different roles like marketing and sales. I was like, well, I I still need
36:25
to be a human in the loop, but for how long? Um, and wait, is it only 6 months?
36:30
I can actually design another loop to automatically adjust the loop when the next model comes out. [ __ ] that's
36:36
[ __ ] damn. Um, what what other roles can AI automate? Can it do policy? Can
36:42
it do construction? Oh, all the data is locked up. When are we going to get the data in one place? Um, oh [ __ ] how do I
36:49
actually differentiate myself when everyone else is like learning and doing this stuff? Oh, it's probably going to
36:55
be the people with audience. Um, and okay, how do I do I need to write
37:02
prompts? Can I just like can I just ask the agent to just watch and observe what I'm doing? How how long until it can
37:08
just learn from what I'm doing? Um, and then you start going like, well, you know, why is everything so slow? If I
37:16
can build this SAS app in a day and I look at government, I'm like, well, government takes like six months to
37:22
write a report. And I'm like, does does it need to take six months? I mean, what actually, you know, and you ask the
37:29
model and you talk to the model and you're like, can you write me some policy? Can you reflect on this? And you're like, well, the model is actually intelligent enough to like think of a
37:35
lot of stuff. Can the model do that job fast? Um,
37:41
and then you start looking at jobs and you look on seek.com. You're like, why is 20% of jobs on seek.com just just
37:47
training just data entry specialists for AIS? What does that even mean? And then you realize the models are actually
37:53
getting really intelligent because we're like hiring people to train them. Um,
37:59
and yeah, and then you know other things you're like, well, are you telling me
38:04
that the AI aren't actually dumb, but like the people who say they're dumb are just dumb themselves. They don't
38:09
actually even know how to use them. Um, or like, you know, are you like saying
38:15
like, well, what why do I even need to read the news? Can't I just get an agent to read it for me? And then like what if
Agent reads news → drafts policy → humans review weekly (governance-as-loop)
38:23
what if the agents were actually drafting stuff in advance for humans to review faster than the humans can
38:29
actually tell the agents? Like why do the humans need to tell the agents at all? Why can't like say it's policy or
38:34
regulation? Say it's a government, right? They create regulations to like protect people, whatever.
38:41
Why why are humans reading the news? Why do the agent could read the news?
38:48
The agent knows what a policy is. Why can't the agent read the news f and just
38:53
draft up new policy ideas and then like the humans just meet once a week and they go all right well here's what's
39:00
changed in the world and here's like this draft of this policy does it look good
39:05
does it not like okay and if it doesn't like do we understand the topic enough well probably I mean yeah what are
39:13
actually the bottlenecks here you know we don't even have to think the agent can do the thinking and it can just come
39:19
come with ideas to us. Um, and yeah, you know, this is like these are all the
39:25
questions of like what happens to work and this is like when you think about using questions because imagine if you
39:31
looked at the other way if you just had ideas and you're like well a policy takes 6 months to develop and an AI
39:38
model can currently review this and like then you like go to use the new models
39:43
and you're like well I believe the model works this way and you're already constraining yourself. you're you're
39:49
like the elephant with the chain and it grows up with a chain on itself and then they take the chain off but it still thinks it's in this like chain. It's
39:56
like no like you got to think of it in terms of questions because questions going to help you learn. Um it's going
40:03
to help you literally have the aperture on your lens of information to be able to see what's possible. Um, and it's
40:11
going to make you feel good because the thing is is like holding on to like how ideas of of of things work is just
40:19
going to like you're just going to get stuck. Um, you're going to get stuck in the moment. You're going to be like the
Why people think models “can’t”: misuse + context-window failure modes
40:25
engineers who are like, "Well, AI can't write code. It can't generate a function
40:31
because it just generates bad code." And it's like well the reason you think that and believe that and think it to be the
40:38
truth is because you don't actually know how to use the model. You are not asking
40:44
can this write code. You're just saying well the way I talk to this like magic
40:49
that we've invented is like not generating the output I want and thus it must just not be capable of it rather
40:56
than saying well maybe I'm actually not understanding how this works. Maybe I don't realize that like you know as the
41:02
AI like gets 50% through its like sort of like working memory its context
41:08
window it just starts getting dumber because um you know it has this like bias up here and like once you realize
41:15
that and you're like [ __ ] all these people who are just saying that it like it just gets dumb after a certain point they don't even realize how it works
41:21
actually and like we're all actually just playing and experimenting but um you know everything has uncertainty Um,
41:29
and that's the whole point is that like questions allow you to at least learn and reduce your uncertainty, whereas
41:36
ideas being held on to statically don't. Um, so anyways, this is my presentation.
Anxiety + resolution: infinite loops imply infinite competition; questions stabilize
41:42
Um, this is like this is all that I'm thinking about right now. Uh, it started off with Ralph. It started off with like
41:49
looping, but really like when I got the loop working and I walked away from it, I realized I'm like I can just make more
41:54
loops. And you know, I was like, damn,
41:59
that's crazy. And I was like, ah, this is so this gives me so much anxiety cuz like where
42:05
is the moat? If the loop can just copy and clone any app, any PNG and the agent
42:12
can obviously learn how to use the operating system. I mean, eventually it's going to be able to do that. What is the moat? And the moat is essentially
42:21
having questions. um questions, you know, how do you out compete? And it's
42:27
like, well, I can just mentally stay stable, stay at peace. Um
42:32
cuz I know that like how I'm approaching the problem is going to be like the most effective way. I will just continue
42:40
asking my questions and I'll refine my questions and over time I'll get better questions and I won't be like so rattled
42:48
by development. Um I'll be able to see information. I'll be able to, you know,
42:53
I won't be like lying to myself by asking some questions which are biased towards one way or another. And um as
43:00
I'm as as I'm doing this, I'm just leveling up the stack. And I just keep asking what's the next bottleneck? What
43:06
can I do to like just just build it better to just like, you know, deliver
43:11
the same value with less cost and faster? And this is what I've come up
43:17
with. You know, the thing is like you just got to you got to be a problem solver. you're going to go, I'm solving
43:22
problems and I'm asking questions. How can I solve these problems better? And I
43:28
see that there are these tools out there. And so I learn the tools and then I go, wow, how what's the limit of these
43:34
tools? What's the bottleneck? And I realize the limit is, you know, you need a human in the loop now because we don't
43:41
exactly understand the limitations, but the the loops are pretty good and the models are pretty good. And there are
43:48
people out there who are like probably smarter than me and that are talking about it and they're they're going like,
43:54
"No, this is the state of the art and the old way is old and it's dead now." And yeah, I mean it's kind of cool. Um,
Wrap: Ralph Wickham, Simpsons movie, thanks
44:02
and yeah, you just continue with that. So anyways, congratulations. [ __ ] Ralph Wickham made it all this way. Uh,
44:09
Simpsons movie was great. Thank you very much.