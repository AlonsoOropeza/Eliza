/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Eliza project for Programming Languages                                 *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Made by:                                                                *
 * Alonso Oropeza & Lissie Serrano <3                                      *
 * Purpose:                                                                *
 * This is a chatbot used to give emotional support to those in need       *
 * It works applying the concepts of cognitive behavioral therapy          *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

%  status stores the emotion of the user
%  name stores the name of user
%  exterior stores the situation of the event, has an additional space for more info
%  interior stores the thought of the user
%  aspect stores the 3 factors that made the user feel that way (relations, work, health, etc)

:- dynamic status/1, name/1, interior/1, exterior/2, aspect/3 .

eliza():-
    introduction(),
    tutorial(),
    begin(),
    process().

begin():-
    write('Let us begin then, what is your name? (lowercase)'),
    read(Name),
    assert(name(Name)),
    write('That is a beautiful name, nice to meet you '),write(Name),nl,
    write('How are you feeling?'),nl,
    read(Emotion),
    assert(status(Emotion)),
    feeling_info(Emotion),
    status(Emotion),
    write('Tell me 3 reason why you feel '),
    write(Emotion),
	ask_aspects().

process():-
    status(E),
    write('Please consider that first we need the understand the situation'), nl,
    write('The situations are the facts, those are neutral'),nl,
    write('Those are the things that are out of our control, we interacte and recieve estimuli from them'),nl,
    write('It is important to exclude perceptions or own inferences'), nl,
    write('What happened that makes you feel '), write(E), write('?'), nl,
    read(Happening),
    assert(exterior(Happening, _)),
    write('Do you want to tell me more?'), nl, write('yes'), nl, write('no'), nl,
    read(Decision),
    extra_exterior(Decision).

bias(pleasant,_):-
    retro().
bias(unpleasant, Thought):-
    aspect(X, Y, Z),
    write('The thought you shared with me was '),nl,
    write(Thought),nl,
    write('I would like to question if this thought is distorted and thus change it'),nl,
    write([overgeneralize,personalize,label,emotional_reasoning,divine_reward_fallacy,
    fallacy_of_justice,maximize_the_negative,culpability,read_minds,catastrophize,
    minimize_the_positive,fallacy_of_change,be_right,polarize,guess_the_future,think_I_should]),
    read(Bias),
    write('Think how is that: '),write(X),write(', '),write(Y),write(' and '),write(Z),
    write(' lead you to '),write(Bias),nl,
    write('Although we cannot control what happens to us, if we can take responsibility for 
           our thoughts, it will make us have better emotional satisfaction'),nl,
    write('Write a new constructive thought based on what you learn'),
    retract(interior(_T)),
    read(NewT),
    assert(interior(NewT)),
    retro().
    
  
retro():-
    status(Emotion),
    write('At the beginning you were '),write(Emotion),nl,
    retract(status(Emotion)),
    interior(Thought),
    write('Then you thought '),write(Thought),nl,
    name(Name),
    write('How do you feel now '),write(Name),write('?'),nl,
    read(NewEmotion),
    assert(status(NewEmotion)),
    comparison(NewEmotion, Emotion).

ask_aspects():-
	read(A),
    read(B),
    read(C),
    assert(aspect(A,B,C)).

thought():-
    status(E),
    level(E, Mood, _, _),
    write('From what you shared with me, can you identify the thought that is behind this '),
    write(Mood),write(' emotion?'),nl,
    write('These are automatic, we do not control them, but are the cause to our emotions'),nl,
    write('On the other hand, the emotions are the reactions to these thoughts'),nl,
    write('With this in mind, can you identify the thought that made you feel this way?'),
    read(Thought),
    assert(interior(Thought)),
    bias(Mood, Thought).

extra_exterior(yes):- 
    exterior(H, _),
    write('Please, write about it'),
    read(Extra),
    assert(exterior(H, Extra)),
    thought().
    
extra_exterior(no):-
    thought().

introduction():-
     write('Hi, I am eliza'),nl,
    write('I was made to give emotional support to those in need'),nl,
    write('We will be working with the cognitive behavioral therapy'),nl,
    write('That means the following:'),nl,
    write('If you take control of your thoughs you can change your emotions'),nl,
    write('That said, I can not replace professional psychological treatment'),nl,
    write('If you want to talk with somebody call this number: 8358-20-00'),nl,
    write('It is from the Advice and Counseling Department of Tec de Monterrey'), nl .
            
tutorial():-
    write('Before starting I need to teach you how we can communicate'   ), nl,
    write('My "Hello world" is written like: [hello, world] '),nl,
    write('I do not like capital letters, please avoid them'   ), nl,
    write('Single word answers are written as normal'), nl.
    
information(pleasant, high, 'the hype to continue what we are living, and focus ourselves in the present').
information(pleasant, low, 'the realization that we are where we want to be, and we can keep the same').
information(unpleasant, low, 'the oportunity to focus in any aspect from our past to move forward').
information(unpleasant, high, 'the impulse to stop what make us uncomfortable and start the action to achieve our claims').

level(thoughtful, pleasant, low, two).
level(loving, pleasant, low, two).
level(fulfilled, pleasant, low, two).
level(grateful, pleasant, low, two).
level(touched, pleasant, low, two).
level(blessed, pleasant, low, two).
level(balanced, pleasant, low, two).
level(peaceful, pleasant, low, two).
level(comfy, pleasant, low, two).
level(carefree, pleasant, low, two).

level(atease, pleasant, low, one).
level(easygoing, pleasant, low, one).
level(content, pleasant, low, one).
level(calm, pleasant, low, one).
level(secure, pleasant, low, one).
level(satisfied, pleasant, low, one).
level(relaxed, pleasant, low, one).
level(chill, pleasant, low, one).
level(restfull, pleasant, low, one).
level(mellow, pleasant, low, one).
level(good, pleasant, low, one).

level(depressed, unpleasant, low, two).
level(down, unpleasant, low, two).
level(apathetic, unpleasant, low, two).
level(sad, unpleasant, low, two).
level(bored, unpleasant, low, two).
level(disheartened, unpleasant, low, two).
level(tired, unpleasant, low, two).
level(exhausted, unpleasant, low, two).
level(fatigued, unpleasant, low, two).
level(serious, unpleasant, low, two).

level(disgusted, unpleasant, low, one).
level(glum, unpleasant, low, one).
level(dissapointed, unpleasant, low, one).
level(pessimistic, unpleasant, low, one).
level(morose, unpleasant, low, one).
level(discouraged, unpleasant, low, one).
level(alienated, unpleasant, low, one).
level(miserable, unpleasant, low, one).
level(lonely, unpleasant, low, one).
level(despondent, unpleasant, low, one).

level(exhilarated, pleasant, high, two).
level(excstatic, pleasant, high, two).
level(inspired, pleasant, high, two).
level(elated, pleasant, high, two).
level(optimistic, pleasant, high, two).
level(excited, pleasant, high, two).
level(focused, pleasant, high, two).
level(proud, pleasant, high, two).
level(thrilled, pleasant, high, two).
level(hopeful, pleasant, high, two).
level(playful, pleasant, high, two).
level(blissful, pleasant, high, two).

level(surprised, pleasant, high, one).
level(upbeat, pleasant, high, one).
level(festive, pleasant, high, one).
level(hyper, pleasant, high, one).
level(cheerful, pleasant, high, one).
level(motivated, pleasant, high, one).
level(lively, pleasant, high, one).
level(enthusiastic, pleasant, high, one).
level(energized, pleasant, high, one).
level(pleased, pleasant, high, one).
level(happy, pleasant, high, one).
level(pleassant, pleasant, high, one).
level(joyful, pleasant, high, one).

level(jittery, unpleasant, high, two).
level(shocked, unpleasant, high, two).
level(tense, unpleasant, high, two).
level(stunned, unpleasant, high, two).
level(nervous, unpleasant, high, two).
level(restless, unpleasant, high, two).
level(irritated, unpleasant, high, two).
level(annoyed, unpleasant, high, two).
level(uneasy, unpleasant, high, two).
level(peeved, unpleasant, high, two).
level(apprehensive, unpleasant, high, two).

level(enraged, unpleasant, high, one).
level(panicked, unpleasant, high, one).
level(stressed, unpleasant, high, one).
level(livid, unpleasant, high, one).
level(furious, unpleasant, high, one).
level(frustrated, unpleasant, high, one).
level(fumming, unpleasant, high, one).
level(frightened, unpleasant, high, one).
level(angry, unpleasant, high, one).
level(anxious, unpleasant, high, one).
level(repulsed, unpleasant, high, one).
level(troubled, unpleasant, high, one).


grouping([], _X, _Y, _Z, Aux, Aux).
grouping([H|T], X, Y, Z, Aux, Res):-
    level(H, X, Y, Z),
    grouping(T, X, Y, Z, [H|Aux], Res).
grouping([_H|T], X, Y, Z, Aux, Res):-
    level(_,X,Y, Z),
    grouping(T, X, Y, Z, Aux, Res).

comparison(NewEmotion, Emotion):-
    level(Emotion, pleasant,_,_),
    level(NewEmotion, pleasant, _,_),
    write('Thank you for the exercise!'), nl, 
    write('It is a good practice to take into notice suggestions even when we are at our best :D');
    level(Emotion, unpleasant,_,_),
    level(NewEmotion, unpleasant, _,_),
    write('We hope that this excercise and the information given could help you on the long term :)');
    level(Emotion, unpleasant,_,_),
    level(NewEmotion, pleasant, _,_),
    write('Thank you for the exercise!'), nl, 
    write('With practice, this process will become a reconfiguration of our thinking to manage our emotions :O').


knowledge(M, Fr):-
    information(M, Fr, Description),
    write('This group of feelings give us '),
    write(Description), nl.

feeling_info(E):-
    level(E, Mood, Frequency, Group),
    feeling(F),
    grouping(F, Mood, Frequency, Group, [], R),
    write('Did you know that '),write(R),write(' share the same mood and frequency?'), nl,
    knowledge(Mood, Frequency).

feeling(L) :- findall(X, (level(X, _, _, _)), L).
