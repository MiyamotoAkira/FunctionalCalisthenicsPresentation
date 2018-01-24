#lang slideshow

(require slideshow/code)
(require slideshow/step)
(require "base.rkt")
(require "fsharp-code.rkt")



(slide
 (text "Functional Calisthenics" (current-main-font) 60)
 (t "Jorge Gueorguiev Garcia")
 (bitmap "codurance.png"))

(slide
 (comment "What is this? Without context there is no meaning. Or rather we are left to
create our meaning. If I put the context of trumpet playing, then 'ta' becomes the representation of the attacking pattern to start sound. As a student or profressional trumpet player you will practice this constantitly as part of your scales, arpegios and études.")
 (wrapper (text "ta" (current-main-font) 48)))

(slide
 (comment "Now that I have a context you know that 'taka' has to do with an attacking pattern. At some speed 'ta' is not good enough. The movement of the tongue is too slow to keep pace. The 'ka' attacking pattern represents the use of the back of your tongue (a velar phoneme) to cut and restart the air flow. And you do require quite some practice to master it.")
 (wrapper (text "taka" (current-main-font) 48)))

(slide
 (comment "Now you have the information about what the above represents. Both the how and why (physical movement and speed). Again, this requires a lot of practice. As a professional trumpet player you will go through this everyday. Scales, arpegios, études ...")
 (wrapper (text "tataka" (current-main-font) 48)))

(with-steps
 (into first second)
 (slide
  (wrapper
   (vc-append
    gap-size
    ((vafter first) (text "Practice makes the master" (current-main-font) 48))
    ((vafter second) (text "But practice with a goal" (current-main-font) 48))))))

(with-steps
 (intro first second third)
 (slide
  #:title "The Clojure Experiment"
  (comment "I like functional programming. I have done functional programming at home. Testing things here and there. I have used F#. I have use Clojure. I have used Elixir. But ... all what I did was small pieces of code under no pressure. At Codurance I had the opportunity of working on my first production functional code. And soon I found myself, as the deadlines was looming, back into my well trained OO and imperative programming. On one side, it did allow me to move quickly. On the other side, the resulting code was a mess. Difficult to understand and difficult to change. At the end I came to realize that all that practicing that I have done for my OOP skills needed to be replicated on FP.")
  (wrapper-titleless
   (vc-append
    gap-size
    ((vafter first) (text "First functional production code" (current-main-font) 48))
    ((vafter second) (text "Back to well trained imperative patterns" (current-main-font) 48))
    ((vafter third) (text "The code was a mess" (current-main-font) 48))))))

(with-steps
 (intro first second third)
 (slide
  #:title "Functional Calisthenics"
  (comment "Which is were Functional Calisthenics come into play. They were originally set at Socrates UK 2015. I decided to have a stab at them. But there were a few rules that I disagree with, and sadly there was missing something I considered important: Why?. So we got together a group of developers at Codurance and rewrote them. They are not a finished work. And we are not the owners of the truth. I will explain why we have each one. But I will happily stand corrected if that means improving my craft.")
  (wrapper-titleless
   (vc-append
    gap-size
    ((vafter first) (text "Original version during Socrates UK 2015" (current-main-font) 48))
    ((vafter second) (text "First stab led to rewrite" (current-main-font) 48))
    ((vafter third) (text "A work in progress" (current-main-font) 48))))))

(with-steps
 (intro first second)
 (slide
  #:title "End Goal"
  (wrapper-titleless
   (vc-append
    gap-size
    ((vafter first) (text "Pureness" (current-main-font) 48))
    ((vafter second) (text "Composable Abstractions" (current-main-font) 48))))))

(with-steps
 (intro first second)
 (slide
  #:title "The application"
  (comment "All what I am going to send is for practice. What you do on production code will depend. Because not all functional languages are equal. They have different characteristics. For example, I remember a presentation by Phil (Trelford) about the use of mutable collections on F# for performance purposes. Furthermore, some of the rules are either forced into you by the language (for example, Haskell forces a few of these rules). Or are simply not possible (the pipe operator or currying in Erlang for the rule \"Do not use intermediate variables\")")
  (rb-superimpose
   (cc-superimpose
    (linewidth 0 (frame (titleless-page) #:color "white"))
    (vc-append gap-size
               ((vafter first) (text "This is for practice" (current-main-font) 48))
               ((vafter second) (text "Each language has its own characteristics" (current-main-font) 48))))
   output-footer)))

(slide
 #:title "The Rules"
 (comment "These are the rules as they currently stand. We will be looking at examples of each one as we move along.")
 (rb-superimpose
  (cc-superimpose
   (linewidth 0 (frame (titleless-page) #:color "white"))
   (vc-append gap-size
              (item "Name everything")
              (item "No Mutable State")
              (item "Expressions, Not Statemets")
              (item "Exhaustive Conditionals")
              (item "Do Not Use Intermediate Variables")
              (item "No Explicit Recursion")
              (item "Generic Building Blocks")
              (item "Side Effects At The Boundaries")
              (item "Infinite Sequences")
              (item "One Argument Functions")))
  output-footer))

(with-steps
 (intro first second third fourth)
 (slide
  #:title "Conway's Game of Life"
  (comment "Does anyone not know the game of life? Created in 1970 by John Horton Conway. Interesting because from a very simple set of rules you can create some sofisticated elements. When I originally heard about it I learned about gliders, and guns, and oscillators. And then, not long ago I discovered that you can create an Universal Turing Machine from it.")
  (rb-superimpose
   (cc-superimpose
    (linewidth 0 (frame (titleless-page) #:color "white"))
    (vc-append gap-size
               ((vafter first) (item "Cells are alive or dead"))
               ((vafter second) (item "Universe is a grid of squares"))
               ((vafter third) (item "Cell stays alive if 2 or 3 neighbours"))
               ((vafter fourth) (item "Dead cell will come to life if it has 3 neighbours"))))
   output-footer)))


(slide
 #:title "Some declarations"
 (rb-superimpose
  (cc-superimpose
   (linewidth 0 (frame (titleless-page) #:color "white"))
   (vl-append 0 (declarations-fsharp)))
  output-footer))

(with-steps
 (intro first second nonames withnames)
 (slide
  #:title "Name Everything"
  (vc-append gap-size
             ((vafter first)
              (t "Everything should have a name"))
             ((vafter second)
              (t "(Including lambdas/anonymous functions)")))
  (lt-superimpose
   ((vonly nonames)
    (bad-naming-fsharp))
   ((vonly withnames)
    (good-naming-fsharp)))
  ))

(slide
 #:title "Expressions, not Statements"
 (comment "I have moved its position on this presentation already 4 times. This started as a rule. But after using the rules of no mutable state and side effects on the boundaries there shouldn't be anything to apply here. Expressions, not Statmentes becomes a property of your code.")
 'next
 (t "A rule that becomes a characteristic")
 'next
 (statement-fsharp)
 'next
 (expression-fsharp))

(slide
 #:title "No Mutable State"
 (comment "Mutable state makes reasoning more difficult.")
 'next
 (t "We want to have guarantees about our code")
 'next
 'alts
 (list
  (list (mutable-state-fsharp))
  (list (non-mutable-state-fsharp))))

(slide
 #:title "Exhaustive Conditionals"
 (comment "There is some help from F# here. Match statements need to be exhaustive. You can't define a match that is not exhaustive. The example on the screen throws an error at compile time. But, it is happy to allow ifs without else. We don't want that. There are two reasons for an if without an else: side effects and mutability. The latter we have already said we don't want, the former we will talk about later.")
 'next
 (t "All your ifs, matches, cases should be able")
 (t "to deal with all possible input")
 'next
 'alts
 (list
  (list (non-exhaustive-1-fsharp))
  (list (exhaustive-1-fsharp))
  (list (non-exhaustive-2-fsharp))
  (list (exhaustive-2-fsharp))))

(slide
 #:title "Do not use intermediate variables"
 (comment "I want you to notice that this is a test. All these rules still apply to tests. Tests is code. But wait, we said that we want names on everything. If we want names and no intermediate variables we need to push them out. Maybe we can consider constants (cheating a bit). They can be reused on multiple tests. But if not, we are removing locality.")
 'next
 (t "It is about the flow of data transformations")
 'next
 'alts
 (list
  (list (intermediate-variables-fsharp))
  (list (non-intermediate-variables-fsharp))
  (list (non-intermediate-variables-alternate-fsharp))))

(slide
 #:title "No Explicit Recursion"
 (comment "")
 'next
 (t "Map and Reduce should be used instead")
 'next
 'alts
 (list
  (list (recursion-fsharp))
  (list (non-recursion-fsharp))
  (list (non-recursion-alternate-fsharp))))

(slide
 #:title "Generic Building Blocks"
 (comment "The Born function is very aware of the domain in which it is working. Its even aware of the fact that is a Life of game on a square's grid. But what if we wanted to use an hexagonal grid? The rule for being born is different (2 neighbours, instead of 3). So now we pass a function that does the needed calculation. Born is kind of domain aware still, but much looser than before. By the way, let's gonna give a few names")
 'next
 (t "Try to create functions that are not domain aware")
 'next
 (t "We are trying to create composable abstractions")
 'next
 'alts
 (list
  (list (non-generic-building-block-fsharp))
  (list (generic-building-block-fsharp))
  (list (generic-building-block-alternate-fsharp))))

(slide
 #:title "Side effects at the boundaries"
 (comment "As soon as one function is not pure, every caller to it is not pure as well. We want to limit the non-pureness. We want to restrict where we have side effect. Here we have a call into a database action in the middle of our Born function. We want to store all new borns ... Dependency Injection ... We can keep pushing out ... In this case it goes into our main. Does it push business logic out into main? Our main is the composition root. At the composition root we can interleave.")
 (t "Keep your functions pure")
 'next
 'alts
 (list
  (list (side-effect-fsharp))
  (list (side-effect-injection-fsharp))
  (list (side-effect-out-fsharp))
  (list (side-effect-out-alternate-fsharp))))

(slide
 #:title "Infinite Sequences"
 'next
 (t "Don't use fixed sized collections")
 'next
 (t "Don't depend on the length of the collection")
 'next
 'alts
 (list
  (list (non-sequence-fsharp))
  (list (sequence-fsharp))))

(slide
 #:title "One argument functions"
 'next
 (t "Functions should have a single argument")
 'next
 'alts
 (list
  (list (multiple-arguments-fsharp))
  (list (single-argument-fsharp))
  (list (multiple-arguments-2-fsharp))
  (list (composition-fsharp))))

(slide
 #:title "The Links"
 (hbl-append 0 (t "Our take:") (colorize (t " https://tinyurl.com/functional-calisthenics") "blue"))
 (hbl-append 0 (t "The original:") (colorize (t " https://tinyurl.com/original-calisthenics") "blue"))
 (hbl-append 0 (t "Kata modifications:") (colorize (t " https://tinyurl.com/katas-calisthenics") "blue")))

(slide
 #:title "The end"
 (t "Jorge Gueorguiev Garcia")
 (t "@yefoakira")
 (bitmap "codurance.png"))
