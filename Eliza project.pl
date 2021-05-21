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
    write('Hi, I am eliza'),nl,
    write('I was made to give emotional support to those in need'),nl,
    write('We will be working with the cognitive behavioral therapy'),nl,
    write('That means the following:'),nl,
    write('If you take control of your thoughs you can change your emotions'),nl,
    write('That said, I can not replace professional psychological treatment'),nl,
    write('If you want to talk with somebody call this number: 8358-20-00'),nl,
    write('It is from the Advice and Counseling Department of Tec de Monterrey'), nl,
    begin().

begin():-
    write('Lets begin then, what is your name? (lowercase)'),
    read(Name),
    assert(name(Name)),
    write('That is a beautiful name, nice to meet you '),write(Name),nl,
    write('How are you feeling?'),nl,
    read(Emotion),
    assert(status(Emotion)),
    feelinginfo(Emotion),
    status(Emotion),
    write('Tell me 3 reason why you feel '),
    write(Emotion),
	askaspects(),
    process().

process():-
    status(E),
    aspect(X, Y, Z),
    write('Please consider that first we need the understand the situation'), nl,
    write('The situations are the facts, those are neutral'),nl,
    write('Those are the things that are out of our control, we interacte and recieve estimuli from them'),nl,
    write('It is important to exclude perceptions or own inferences'), nl,
    write('What happened that makes you feel '), write(E), write('?'), nl,
    read(Happening),
    assert(exterior(Happening, _)),
    write('Do you want to tell me more?'), nl, write('yes'), nl, write('no'), nl,
    read(Decision),
    extraexterior(Decision, Happening),
    level(E, Mood, _),
    write('From what you shared with me, can you identify the thought that is behind this '),
    write(Mood),write(' emotion?'),nl,
    write('These are automatic, we do not control them, but are the cause to our emotions'),nl,
    write('On the other hand, the emotions are the reactions to these thoughts'),nl,
    write('With this in mind, can you identify the thought that made you feel this way?'),
    read(Thought),
    assert(interior(Thought)),
    bias(Mood, Thought, X, Y, Z).

bias(pleasant,_,_,_,_):-
    retro().
bias(unpleasant, Thought,X,Y,Z):-
    write('The thought you shared with me was '),nl,
    write(Thought),nl,
    write('I would like to question if this thought is distorted and thus change it'),nl,
    write([overgeneralize,personalize,label,emotional_reasoning,divine_reward_fallacy,
    fallacy_of_justice,maximize_the_negative,culpability,read_minds,catastrophize,
    minimize_the_positive,fallacy_of_change,be_right,polarize,guess_the_future,think_I_should]),
    read(Bias),
    write('Think how is that: '),write(X),write(', '),write(Y),write('and '),write(Z),
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

askaspects():-
	read(A),
    assert(aspect(A,_,_)),
    read(B),
    assert(aspect(A, B,_)),
    read(C),
    assert(aspect(A,B,C)).

extraexterior(yes, H):- 
    write('Please, write about it'),
    read(Extra),
    assert(exterior(H, Extra)).
extraexterior(no, _H).
    	
knowledge(M, Fr):-
    information(M, Fr, Description),
    write('This group of feelings give us '),
    write(Description), nl.

feelinginfo(E):-
    level(E, Mood, Frequency),
    feeling(F),
    grouping(F, Mood, Frequency, [], R),
    write('Did you know that '),write(R),write(' share the same mood and frequency?'), nl,
    knowledge(Mood, Frequency).
    
information(pleasant, high, 'the hype to continue what we are living, and focus ourselves in the present').
information(pleasant, low, 'the realization that we are where we want to be, and we can keep the same').
information(unpleasant, high, 'the oportunity to focus in any aspect from our past to move forward').
information(unpleasant, low, 'the impulse to stop what make us uncomfortable and start the action to achieve our claims').


level(motivated, pleasant, high).
level(cheerful, pleasant, high).
level(excited, pleasant, high).
level(surprised, pleasant, high).
level(happy, pleasant, high).
level(proud, pleasant, high).
level(ecstatic, pleasant, high).
level(focus, pleasant, high).
level(fascinated, pleasant, high).
level(enthusiastic, pleasant, high).
level(lovely, pleasant, high).
level(optimistic, pleasant, high).

level(grateful, pleasant, low).
level(loving, pleasant, low).
level(chill, pleasant, low).
level(carefree, pleasant, low).
level(calm, pleasant, low).
level(comfortable, pleasant, low).
level(relaxed, pleasant, low).
level(blessed, pleasant, low).
level(sleepy, pleasant, low).
level(inspired, pleasant, low).
level(satisfied, pleasant, low).
level(hopeful, pleasant, low).

level(angry, unpleasant, high).
level(stressed, unpleasant, high).
level(worried, unpleasant, high).
level(annoyed, unpleasant, high).
level(anxious, unpleasant, high).
level(scared, unpleasant, high).
level(shocked, unpleasant, high).
level(frustrated, unpleasant, high).
level(irritated, unpleasant, high).
level(furious, unpleasant, high).
level(disgusted, unpleasant, high).
level(dispared, unpleasant, high).
level(nervious, unpleasant, high).
level(worried, unpleasant, high).
level(scared, unpleasant, high).
level(desparate, unpleasant, high).

level(lonely, unpleasant, low).
level(sad, unpleasant, low).
level(bored, unpleasant, low).
level(depressed, unpleasant, low).
level(tired, unpleasant, low).
level(dissapointed, unpleasant, low).
level(exhausted, unpleasant, low).
level(miserable, unpleasant, low).
level(melancholic, unpleasant, low).
level(remorseful, unpleasant, low).
level(guilty, unpleasant, low).
level(confused, unpleasant, low).
level(ashamed, unpleasant, low).
level(bored, unpleasant, low).

feeling(L) :- findall(X, (level(X, _, _)), L).

grouping([], _X, _Y, Aux, Aux).
grouping([H|T], X, Y, Aux, Res):-
    level(H, X, Y),
    grouping(T, X, Y, [H|Aux], Res).
grouping([_H|T], X, Y, Aux, Res):-
    level(_,X,Y),
    grouping(T, X, Y, Aux, Res).

comparison(NewEmotion, Emotion):-
    level(Emotion, pleasant,_),
    level(NewEmotion, pleasant, _),
    write('Thank you for the exercise!'), nl, 
    write('It is a good practice to take into notice suggestions even when we are at our best :D');
    level(Emotion, unpleasant,_),
    level(NewEmotion, unpleasant, _),
    write('We hope that this excercise and the information given could help you on the long term :)');
    level(Emotion, unpleasant,_),
    level(NewEmotion, pleasant, _),
    write('Thank you for the exercise!'), nl, 
    write('With practice, this process will become a reconfiguration of our thinking to manage our emotions :O').


