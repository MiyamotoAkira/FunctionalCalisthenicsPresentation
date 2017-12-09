#lang slideshow

(require slideshow/code)
(require slideshow/step)

(define (wrapper p)
  (rb-superimpose
   (cc-superimpose
    (linewidth 0 (frame (blank client-w client-h) #:color "white"))
    p)
   (bitmap "footer-logo.png")))

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
 (rb-superimpose
  (cc-superimpose
   (linewidth 0 (frame (blank client-w client-h) #:color "white"))
   (text "taka" (current-main-font) 48))
  (bitmap "footer-logo.png")) )

(slide
 (comment "Now you have the information about what the above represents. Both the how and why (physical movement and speed). Again, this requires a lot of practice. As a professional trumpet player you will go through this everyday. Scales, arpegios, études ...")
 (rb-superimpose
  (cc-superimpose
   (linewidth 0 (frame (blank client-w client-h) #:color "white"))
   (text "tataka" (current-main-font) 48))
  (bitmap "footer-logo.png")))

(with-steps
 (into first second)
 (slide
  (rb-superimpose
   (cc-superimpose
    (linewidth 0 (frame (blank client-w client-h) #:color "white"))
    (vc-append gap-size
               ((vafter first)
                (text "Practice makes the master" (current-main-font) 48))
               ((vafter second)
                (text "But practice with a goal" (current-main-font) 48))))
   (bitmap "footer-logo.png"))))

(with-steps
 (intro first second third)
 (slide
  #:title "The Clojure Experiment"
   (vc-append gap-size
              ((vafter first)
               (text "First functional production code" (current-main-font) 48))
              ((vafter second) (text "Back to well trained imperative patterns" (current-main-font) 48))
              ((vafter third) (text "The code was a mess" (current-main-font) 48)))
  (comment "I like functional programming. I have done functional programming at home. Testing things here and there. I have used F#. I have use Clojure. I have used Elixir. But ... all what I did was small pieces of code under no pressure. At Codurance I had the opportunity of working on my first production functional code. And soon I found myself, as the deadlines was looming, back into my well trained OO and imperative programming. On one side, it did allow me to move quickly. On the other side, the resulting code was a mess. Difficult to understand and difficult to change. At the end I came to realize that all that practicing that I have done for my OOP skills needed to be replicated on FP.")))

(slide
 #:title "Functional Calisthenics"
 (comment "Which is were Functional Calisthenics come into play. They were originally set at Socrates UK 2015. I decided to have a stab at them. But there were a few rules that I disagree with, and sadly there was missing something I considered important: Why?. So we got together a group of developers at Codurance and rewrote them. They are not a finished work. And we are not the owners of the truth. I will explain why we have each one. But I will happily stand corrected if that means improving my craft.")
 'next
 (text "Original version during Socrates UK 2015" (current-main-font) 48)
 'next
 (text "First stab led to rewrite" (current-main-font) 48)
 'next
 (text "A work in progress" (current-main-font) 48))

(slide
 #:title "End Goal"
 'next
 (text "Pureness" (current-main-font) 48)
 'next
 (text "Composable Abstractions" (current-main-font) 48))

(slide
 #:title "The application"
 (comment "All what I am going to send is for practice. What you do on production code will depend. Because not all functional languages are equal. They have different characteristics. For example, I remember a presentation by Phil (Trelford) about the use of mutable collections on F# for performance purposes. Furthermore, some of the rules are either forced into you by the language (for example, Haskell forces a few of these rules). Or are simply not possible (the pipe operator or currying in Erlang for the rule \"Do not use intermediate variables\")")
 'next
 (text "This is for practice" (current-main-font) 48)
 'next
 (text "Each language has its own characteristics" (current-main-font) 48))

(slide
 #:title "The Rules"
 (comment "These are the rules as they currently stand. We will be looking at examples of each one as we move along.")
 (item "Name everything")
 (item "No Mutable State")
 (item "Expressions, Not Statemets")
 (item "Exhaustive Conditionals")
 (item "Do Not Use Intermediate Variables")
 (item "No Explicit Recursion")
 (item "Generic Building Blocks")
 (item "Side Effects At The Boundaries")
 (item "Infinite Sequences")
 (item "One Argument Functions"))

(slide
 #:title "Conway's Game of Life"
 (comment "Does anyone not know the game of life? Created in 1970 by John Horton Conway. Interesting because from a very simple set of rules you can create some sofisticated elements. When I originally heard about it I learned about gliders, and guns, and oscillators. And then, not long ago I discovered that you can create an Universal Turing Machine from it.")
 'next
 (item "Cells are alive or dead")
 (item "Universe is a grid of squares")
 (item "Cell stays alive if 2 or 3 neighbours")
 (item "Dead cell will come to life if it has 3 neighbours"))

(define (function s)
  (colorize (tt s) "light blue"))

(define (keyword s)
  (colorize (tt s) "blue"))

(define (parameter s)
  (colorize (tt s) "orange"))

(define (letk) (keyword "let "))

(define (equal) (keyword "= "))

(define (tab) (tt "    "))

(slide
 #:title "Some declarations"
 (vl-append 0
            (hbl-append 0 (keyword "type ") (function "Cell ") (equal) (keyword "{") (tt "x") (keyword ": int; ") (tt "y") (keyword ": int}") )
            (tt "")
            (hbl-append 0
                        (keyword "let ")
                        (function "neighbours ")
                        (keyword "= [")
                        (tt "(-1,-1)")
                        (keyword "; ")
                        (tt "(0,-1)")
                        (keyword "; ")
                        (tt "(1,-1)")
                        (keyword "; ")
                        (tt "(-1,0)")
                        (keyword "; "))
            (hbl-append 0
                        (tt "                  ")
                        (tt "(1,0)")
                        (keyword "; ")
                        (tt "(-1,1)")
                        (keyword "; ")
                        (tt "(0,1)")
                        (keyword "; ")
                        (tt "(1,1)")
                        (keyword ";]"))))

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
    (vl-append 0
               (hbl-append 0 (letk) (function "GetNeighbours") (parameter " (cell:Cell) : List<Cell> ") (keyword "="))
               (hbl-append 0 (tab) (letk) (keyword "rec ") (function "FindNeighbours ") (parameter "neighbours universe ") (equal))
               (hbl-append 0 (tab) (tab) (keyword "match ") (tt "neighbours ") (keyword "with"))
               (hbl-append 0 (tab) (tab) (keyword "| ") (keyword "[] -> ") (tt "universe"))
               (hbl-append 0 (tab) (tab) (keyword "| ") (tt "H") (keyword "::") (tt "T ") (keyword "->"))
               (hbl-append 0 (tab) (tab) (tab) (tt "FindNeighbours T ("))
               (hbl-append 0 (tab) (tab) (tab) (tab) (keyword "{") (tt "x ") (equal) (tt "cell.x ") (keyword "+ ") (tt "fst H") (keyword ";"))
               (hbl-append 0 (tab) (tab) (tab) (tab) (tt " y ") (equal) (tt "cell.y ") (keyword "+ ") (tt "snd H") (keyword "}"))
               (hbl-append 0 (tab) (tab) (tab) (tab) (keyword ":: ") (tt "universe)"))
               (hbl-append 0 (tab) (tt "FindNeighbours neighbours ") (keyword "[]"))
               (hbl-append 0 (tab) (keyword "|> ") (tt "List.rev"))))
   ((vonly withnames)
    (vl-append 0
               (hbl-append 0 (keyword "let ") (function "AddNeighbour ") (parameter "cell universe mods ") (equal))
               (hbl-append 0 (tab) (keyword "{") (tt "x ") (equal) (tt "cell.x ") (keyword "+ ") (tt "fst mods") (keyword ";"))
               (hbl-append 0 (tab) (tt " y ") (equal) (tt "cell.y ") (keyword "+ ") (tt "snd mods") (keyword "}"))
               (hbl-append 0 (tab) (keyword ":: ") (tt "universe"))
               (tt "")
               (hbl-append 0 (letk) (function "GetNeighbours") (parameter " (cell:Cell) : List<Cell> ") (equal))
               (hbl-append 0 (tab) (letk) (keyword "rec ") (function "FindNeighbours ") (parameter "neighbours universe ") (equal))
               (hbl-append 0 (tab) (tab) (keyword "match ") (tt "neighbours ") (keyword "with"))
               (hbl-append 0 (tab) (tab) (keyword "| [] -> ") (tt "universe"))
               (hbl-append 0 (tab) (tab) (keyword "| ") (tt "H") (keyword "::") (tt "T ") (keyword "->"))
               (hbl-append 0 (tab) (tab) (tab)) (tt "FindNeighbours T (AddNeighbour cell universe H)")
               (hbl-append 0 (tab) (tt "FindNeighbours neighbours ") (keyword "[]"))

               (hbl-append 0 (tab) (keyword "|> ") (tt "List.rev")))))))

(slide
 #:title "Expressions, not Statements"
 (comment "I have moved its position on this presentation already 4 times. This started as a rule. But after using the rules of no mutable state and side effects on the boundaries there shouldn't be anything to apply here. Expressions, not Statmentes becomes a property of your code.")
 'next
 (t "A rule that becomes a characteristic")
 'next
 (tt "SomeFunctionCall someparameter")
 'next
 (hbl-append 0 (letk) (function "someResult ") (equal) (tt "SomeFunctionCall someparameter")))

(slide
 #:title "No Mutable State"
 (comment "Mutable state makes reasoning more difficult.")
 'next
 (t "We want to have guarantees about our code")
 'next
 'alts
 (list
  (list
   (vl-append
    0
    (hbl-append 0 (letk) (function "FindOnUniverse ") (parameter "universe (alive:byref<_>) ") (keyword "="))
    (hbl-append 0 (tab) (tt "alive ") (keyword "<- ") (tt "some_calculation"))
    (tt " ")
    (hbl-append 0 (letk) (function "CheckIfAlive ") (parameter "cell universe ") (keyword "="))
    (hbl-append 0 (tab) (letk) (keyword "mutable ") (function "alive ") (keyword "= ") (tt "GetNeighbours cell"))
    (hbl-append 0 (tab) (tt "FindOnUniverse universe ") (keyword "&") (tt "alive"))
    (hbl-append 0 (tab) (tt "(List.length alive) ") (equal) (tt "2"))
    (hbl-append 0 (tab) (keyword "|| ") (tt "(List.length alive ") (equal) (tt "3"))))
  (list
   (vl-append
    0
    (hbl-append 0 (letk) (function "FindOnUniverse ") (parameter "universe alive ") (equal) (tt "..."))
    (tt " ")
    (hbl-append 0 (letk) (function "CheckIfAlive ") (parameter "cell universe ") (keyword "="))
    (hbl-append 0 (tab) (letk) (function "neighbours ") (equal) (tt "GetNeighbours cell"))
    (hbl-append 0 (tab) (letk) (function "alive ") (equal) (tt "FindOnUniverse universe neighbours"))
    (hbl-append 0 (tab) (tt "(List.length alive) ") (equal) (tt "2"))
    (hbl-append 0 (tab) (keyword "|| ") (tt "(List.length alive ") (equal) (tt "3"))
    ))))

(slide
 #:title "Exhaustive Conditionals"
 (comment "There is some help from F# here. Match statements need to be exhaustive. You can't define a match that is not exhaustive. The example on the screen throws an error at compile time. But, it is happy to allow ifs without else. We don't want that. There are two reasons for an if without an else: side effects and mutability. The latter we have already said we don't want, the former we will talk about later.")
 'next
 (t "All your ifs, matches, cases should be able")
 (t "to deal with all possible input")
 'next
 'alts
 (list
  (list
   (vl-append
    0
    (hbl-append 0 (keyword "match ") (tt "CheckIfAlive elem universe ") (keyword "with "))
    (hbl-append 0 (keyword "| true -> ") (tt "elem ") (keyword ":: ") (tt "acc"))))
  (list
   (vl-append
    0
    (hbl-append 0 (keyword "match ") (tt "CheckIfAlive elem universe ") (keyword "with "))
    (hbl-append 0 (keyword "| true -> ") (tt "elem ") (keyword ":: ") (tt "acc"))
    (hbl-append 0 (keyword "| false -> ") (tt "acc"))))
  (list
   (vl-append
    0
    (hbl-append 0 (keyword "if ") (tt "x ") (equal) (tt "\"let's go\" ") (keyword "then"))
    (hbl-append 0 (tab) (tt "printf \"hey\""))))
  (list
   (vl-append
    0
    (hbl-append 0 (keyword "if ") (tt "x ") (equal) (tt "\"let's go\" ") (keyword "then"))
    (hbl-append 0 (tab) (tt "printf \"hey\""))
    (keyword "else")
    (hbl-append 0 (tab) (tt "printf \"ho\""))))))

(slide
 #:title "Do not use intermediate variables"
 (comment "I want you to notice that this is a test. All these rules still apply to tests. Tests is code. But wait, we said that we want names on everything. If we want names and no intermediate variables we need to push them out. Maybe we can consider constants (cheating a bit). They can be reused on multiple tests. But if not, we are removing locality.")
 'next
 (t "It is about the flow of data transformations")
 'next
 'alts
 (list
  (list
   (vl-append
    0
    (hbl-append 0 (letk) (function "CompareWith ") (parameter "expected actual ") (equal))
    (tt "    Assert.True (CompareList expected actual)")
    (tt "")
    (hbl-append 0 (letk) (function "``Empty cell becomes alive`` ") (keyword "() ") (equal))
    (hbl-append 0 (tab) (letk) (function "u3 ") (equal) (keyword "["))
    (hbl-append 0 (tab) (tab) (keyword "{") (tt "x ") (equal) (tt "-1") (keyword "; ") (tt "y ") (equal) (tt "-1") (keyword "};"))
    (hbl-append 0 (tab) (tab) (keyword "{") (tt "x ") (equal) (tt "1") (keyword "; ") (tt "y ") (equal) (tt "1") (keyword "};"))
    (hbl-append 0 (tab) (tab) (keyword "{") (tt "x ") (equal) (tt "-1") (keyword "; ") (tt "y ") (equal) (tt "1") (keyword "}]"))
    (hbl-append 0 (tab) (letk) (function "universe ") (equal) (keyword "[{") (tt "x ") (equal) (tt "0") (keyword "; ") (tt "y ") (equal) (tt "0") (keyword "}]"))
    (hbl-append 0 (tab) (letk) (function "actualUniverse ") (equal) (tt"NextUniverse u3"))
    (hbl-append 0 (tab) (tt "CompareWith universe actualUniverse"))))
  (list
   (vl-append
    0
    (hbl-append 0 (letk) (function "CompareWith ") (parameter "expected actual ") (equal))
    (tt "    Assert.True (CompareList expected actual)")
    (tt "")
    (hbl-append 0 (letk) (function "``Empty cell becomes alive`` ") (keyword "() ") (equal))
    (hbl-append 0 (tab) (keyword "[{") (tt "x ") (equal) (tt "-1") (keyword "; ") (tt "y ") (equal) (tt "-1") (keyword "};"))
    (hbl-append 0 (tab) (keyword " {") (tt "x ") (equal) (tt "1") (keyword "; ") (tt "y ") (equal) (tt "1") (keyword "};"))
    (hbl-append 0 (tab) (keyword " {") (tt "x ") (equal) (tt "-1") (keyword "; ") (tt "y ") (equal) (tt "1") (keyword "}]"))
    (hbl-append 0 (tab) (keyword "|> ") (tt "NextUniverse"))
    (hbl-append 0 (tab) (keyword "|> ") (tt "CompareWith ") (keyword "[{") (tt "x ") (equal) (tt "0") (keyword "; ") (tt "y ") (equal) (tt "0") (keyword "}]"))))
  (list
   (vl-append
    0
    (hbl-append 0 (letk) (function "CompareWith ") (parameter "expected actual ") (equal))
    (tt "    Assert.True (CompareList expected actual)")
    (tt "")
    (hbl-append 0 (letk) (function "expectedUniverse ") (equal))
    (hbl-append 0 (tab) (keyword "[{") (tt "x ") (equal) (tt "0") (keyword "; ") (tt "y ") (equal) (tt "0") (keyword "}]"))
    (tt "")
    (hbl-append 0 (letk) (function "universeWithThreeCells ") (equal))
    (hbl-append 0 (tab) (keyword "[{") (tt "x ") (equal) (tt "-1") (keyword "; ") (tt "y ") (equal) (tt "-1") (keyword "};"))
    (hbl-append 0 (tab) (keyword " {") (tt "x ") (equal) (tt "1") (keyword "; ") (tt "y ") (equal) (tt "1") (keyword "};"))
    (hbl-append 0 (tab) (keyword " {") (tt "x ") (equal) (tt "-1") (keyword "; ") (tt "y ") (equal) (tt "1") (keyword "}]"))
    (tt "")
    (hbl-append 0 (letk) (function "``Empty cell becomes alive`` ") (keyword "() ") (equal))
    (tt "    universeWithThreeCells")
    (hbl-append 0 (tab) (keyword "|> ") (tt "NextUniverse"))
    (hbl-append 0 (tab) (keyword "|> ") (tt "CompareWith expectedUniverse"))))))

(slide
 #:title "No Explicit Recursion"
 (comment "")
 'next
 (t "Map and Reduce should be used instead")
 'next
 'alts
 (list
  (list
   (vl-append
    0
    (hbl-append 0 (letk) (function "AddN ") (parameter "cell universe mods ") (equal))
    (hbl-append 0 (tab) (keyword "{") (tt "x ") (equal) (tt "cell.x ") (keyword "+ ") (tt "fst mods") (keyword ";"))
    (hbl-append 0 (tab) (tt " y ") (equal) (tt "cell.y ") (keyword "+ ") (tt "snd mods") (keyword "}"))
    (hbl-append 0 (tab) (keyword ":: ") (tt "universe"))
    (tt "")
    (hbl-append 0 (letk) (function "GetNeighbours ") (parameter "(cell:Cell) : List<Cell> ") (equal))
    (hbl-append 8 (tab) (letk) (keyword "rec ") (function "FindNeighbours ") (parameter "N U ") (equal))
    (hbl-append 0 (tab) (tab) (keyword "match ") (tt "N ") (keyword "with "))
    (hbl-append 0 (tab) (tab) (keyword "| [] -> ") (tt "U"))
    (hbl-append 0 (tab) (tab) (keyword "| ") (tt "H") (keyword "::") (tt "T ") (keyword "->"))
    (tt "            FindNeighbours T (AddN cell U H)")
    (hbl-append 0 (tt "    FindNeighbours neighbours ") (keyword "[]"))
    (hbl-append 0 (tab) (keyword "|> ") (tt "List.rev"))))
  (list
   (vl-append
    0
    (hbl-append 0 (letk) (function "AddN ") (parameter "cell universe mods ") (equal))
    (hbl-append 0 (tab) (keyword "{") (tt "x ") (equal) (tt "cell.x ") (keyword "+ ") (tt "fst mods") (keyword ";"))
    (hbl-append 0 (tab) (tt " y ") (equal) (tt "cell.y ") (keyword "+ ") (tt "snd mods") (keyword "}"))
    (hbl-append 0 (tab) (keyword ":: ") (tt "universe"))
    (tt "")
    (hbl-append 0 (letk) (function "GetNeighbours ") (parameter "(cell:Cell) : List<Cell> ") (equal))
    (hbl-append 0 (tab) (letk) (function "AddNForCell ") (parameter "acc elem ") (equal) (tt "AddN cell acc elem"))
    (hbl-append 0 (tab) (tt "List.fold AddNForCell ") (keyword "[] ") (tt "neighbours"))
    (hbl-append 0 (tab) (keyword "|> ") (tt "List.rev"))))
  (list
   (vl-append
    0
    (hbl-append 0 (letk) (function "AddN ") (parameter "cell universe mods ") (equal))
    (hbl-append 0 (tab) (keyword "{") (tt "x ") (equal) (tt "cell.x ") (keyword "+ ") (tt "fst mods") (keyword ";"))
    (hbl-append 0 (tab) (tt " y ") (equal) (tt "cell.y ") (keyword "+ ") (tt "snd mods") (keyword "}"))
    (hbl-append 0 (tab) (keyword ":: ") (tt "universe"))
    (tt "")
    (hbl-append 0 (letk) (function "GetNeighbours ") (parameter "(cell:Cell) : List<Cell> ") (equal))
    (hbl-append 0 (tab) (tt "List.fold (AddN cell) ") (keyword "[] ") (tt "neighbours"))
    (hbl-append 0 (tab) (keyword "|> ") (tt "List.rev"))))))

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
  (list
   (vl-append
    0
    (hbl-append 0 (letk) (function "Born ") (parameter "universe ") (equal))
    (hbl-append 0 (tab) (tt "List.fold ") (keyword "-> ") (tt "CollateNeighbours ") (keyword "[] ") (tt "universe"))
    (hbl-append 0 (tab) (keyword "|> ") (tt "Set.ofList"))
    (hbl-append 0 (tab) (keyword "|> ") (tt "Set.toList"))
    (hbl-append 0 (tab) (keyword "|> ") (tt "NotAnyIn universe"))
    (hbl-append (tab) (keyword "|> ") (tt "List.fold (") (keyword "fun ") (tt "acc e ") (keyword "->"))
    (hbl-append (tab) (tab) (tab) (tab) (keyword "match ") (tt "IfThree e universe ") (keyword "with"))
    (hbl-append 0 (tab) (tab) (tab) (tab) (keyword "| true -> ") (tt "e ") (keyword ":: ") (tt "acc"))
    (hbl-append 0 (tab) (tab) (tab) (tab) (keyword "| false -> ") (tt "acc) ") (keyword "[] ") (tt "acc"))))
  (list
   (vl-append
    0
    (hbl-append 0 (letk) (function "Born ") (parameter "check universe ") (equal))
    (hbl-append 0 (tab) (tt "List.fold ") (keyword "-> ") (tt "CollateNeighbours ") (keyword "[] ") (tt "universe"))
    (hbl-append 0 (tab) (keyword "|> ") (tt "Set.ofList"))
    (hbl-append 0 (tab) (keyword "|> ") (tt "Set.toList"))
    (hbl-append 0 (tab) (keyword "|> ") (tt "NotAnyIn universe"))
    (hbl-append (tab) (keyword "|> ") (tt "List.fold (") (keyword "fun ") (tt "acc e ") (keyword "->"))
    (hbl-append (tab) (tab) (tab) (tab) (keyword "match ") (tt "check e universe ") (keyword "with"))
    (hbl-append 0 (tab) (tab) (tab) (tab) (keyword "| true -> ") (tt "e ") (keyword ":: ") (tt "acc"))
    (hbl-append 0 (tab) (tab) (tab) (tab) (keyword "| false -> ") (tt "acc) ") (keyword "[] ") (tt "acc"))
    (tt "")
    (hbl-append (letk) (function "BornWithThree ") (parameter "universe ") (equal))
    (tt "    Born CheckIfThree universe")))
  (list
   (vl-append
    0
    (hbl-append 0 (letk) (function "Born ") (parameter "check universe ") (equal))
    (hbl-append 0 (tab) (tt "List.fold ") (keyword "-> ") (tt "CollateNeighbours ") (keyword "[] ") (tt "universe"))
    (hbl-append 0 (tab) (keyword "|> ") (tt "Dedup"))
    (hbl-append 0 (tab) (keyword "|> ") (tt "NotAnyIn universe"))
    (hbl-append 0 (tab) (keyword "|> ") (tt "CheckAll check"))
    (tt "")
    (hbl-append (letk) (function "BornWithThree ") (parameter "universe ") (equal))
    (tt "    Born CheckIfThree universe")))))

(slide
 #:title "Side effects at the boundaries"
 (comment "As soon as one function is not pure, every caller to it is not pure as well. We want to limit the non-pureness. We want to restrict where we have side effect. Here we have a call into a database action in the middle of our Born function. We want to store all new borns ... Dependency Injection ... We can keep pushing out ... In this case it goes into our main. Does it push business logic out into main? Our main is the composition root. At the composition root we can interleave.")
 (t "Keep your functions pure")
 'next
 'alts
 (list
  (list
   (vl-append
    0
    (hbl-append 0 (letk) (function "SaveBorns ") (parameter "newBorns ") (equal))
    (tt "    ...Saving in database")
    (tt "    newBorns")
    (tt "")
    (hbl-append 0 (letk) (function "Born ") (parameter "check universe ") (equal))
    (tt "...")
    (hbl-append 0 (tab) (keyword "|> ") (tt "CheckAll check"))
    (hbl-append 0 (tab) (keyword "|> ") (tt "SaveBorns"))))
  (list
   (vl-append
    0
    (hbl-append 0 (letk) (function "SaveBorns ") (parameter "newBorns ") (equal))
    (tt "    ...Saving in database")
    (tt "    newBorns")
    (tt "")
    (hbl-append 0 (letk) (function "Born ") (parameter "check universe saving ") (equal))
    (tt "    ...")
    (hbl-append 0 (tab) (keyword "|> ") (tt "CheckAll check"))
    (hbl-append 0 (tab) (keyword "|> ") (tt "saving"))
    (tt "")
    (tt "Born check universe SaveBorns")))
  (list
   (vl-append
    0
    (hbl-append 0 (letk) (function "SaveBorns ") (parameter "newBorns ") (equal))
    (tt "   Saving in database")
    (tt "    newBorns")
    (tt "")
    (hbl-append 0 (letk) (function "Born ") (parameter "check universe ") (equal))
    (tt "...")
    (hbl-append 0 (tab) (keyword "|> ") (tt "CheckAll check"))
    (tt "")
    (hbl-append 0 (letk) (keyword "[<EntryPoint>] ") (function "main ") (parameter "_ ") (equal))
    (tt "...")
    (tt "    Born check universe")
    (hbl-append 0 (tab) (keyword "|> ") (tt "SaveBorns"))))
  (list
   (vl-append
    0
    (hbl-append 0 (letk) (function "SaveBorns ") (parameter "newBorns ") (equal))
    (tt "   Saving in database")
    (tt "    newBorns")
    (tt "")
    (hbl-append 0 (letk) (function "Born ") (parameter "check universe ") (equal))
    (tt "...")
    (hbl-append 0 (tab) (keyword "|> ") (tt "CheckAll check"))
    
    (tt "let [<EntryPoint>] main _ = ")
    (tt "...")
    (tt "    Born check universe")
    (hbl-append 0 (tab) (keyword "|> ") (tt "SaveBorns"))
    (hbl-append 0 (tab) (keyword "|> ") (tt "AddToUniverse"))))))

(slide
 #:title "Infinite Sequences"
 'next
 (t "Don't use fixed sized collections")
 'next
 (t "Don't depend on the length of the collection")
 'next
 'alts
 (list
  (list
   (vl-append
    0
    (hbl-append 0 (letk) (function "FindOnUniverse ") (parameter "list1 list2 ") (equal))
    (tt "    List.filter ")
    (hbl-append 0 (tab) (tab) (tt "(") (keyword "fun ") (tt "(x) ") (keyword "->"))
    (hbl-append 0 (tab) (tab) (tab) (tt "List.exists (") (keyword "fun ") (tt "(y) ") (keyword "-> ") (tt "x ") (equal) (tt "y) list2)"))
    (tt "        list1")))
  (list
   (vl-append
    0
    (hbl-append 0 (letk) (function "FindOnUniverse ") (parameter "seq1 seq2 ") (equal))
    (tt "    Seq.filter ")
    (hbl-append 0 (tab) (tab) (tt "(") (keyword "fun ") (tt "(x) ") (keyword "->"))
    (hbl-append 0 (tab) (tab) (tab) (tt "Seq.exists (") (keyword "fun ") (tt "(y) ") (keyword "-> ") (tt "x ") (equal) (tt "y) seq2)"))
    (tt "        seq1")))))

(slide
 #:title "One argument functions"
 'next
 (t "Functions should have a single argument")
 'next
 'alts
 (list
  (list
   (vl-append
    0
    (hbl-append 0 (letk) (function "FindOnUniverse ") (parameter "seq1 seq2 ") (equal))
    (tt "    Seq.filter ")
    (hbl-append 0 (tab) (tab) (tt "(") (keyword "fun ") (tt "(x) ") (keyword "->"))
    (hbl-append 0 (tab) (tab) (tab) (tt "Seq.exists (") (keyword "fun ") (tt "(y) ") (keyword "-> ") (tt "x ") (equal) (tt "y) seq2)"))
    (tt "        seq1")))
  (list
   (vl-append
    0
    (hbl-append 0 (letk) (function "CheckExistence ") (parameter "onSeq ") (equal))
    (hbl-append 0 (tab) (keyword "fun") (tt "(x) ") (keyword "-> ") (tt "Seq.exists (") (keyword "fun") (tt "(y) ") (keyword "-> ") (tt "x ") (equal) (tt "y) onSeq"))
    (tt "")
    (hbl-append 0 (letk) (function "Find ") (parameter "possibles ") (equal))
    (tt "    Seq.Filter (CheckExistence universe) possibles")))
  (list
   (vl-append
    0
    (hbl-append 0 (letk) (function "CheckIfThree ") (parameter "cell universe ") (equal))
    (hbl-append 0 (tab) (letk) (function "allNeighs ") (equal) (tt "GetNeighbours cell"))
    (hbl-append 0 (tab) (letk) (function "alive ") (equal) (tt "FindOnUniverse universe allNeighs"))
    (hbl-append 0 (tab) (tt "List.length alive ") (equal) (tt "3"))))
  (list
   (vl-append
    0
    (hbl-append 0 (letk) (function "FWU ") (equal) (tt "FindOnUniverse universe"))
    (hbl-append 0 (letk) (function "CheckForThree ") (parameter "alive ") (equal) (tt "List.length alive ") (equal) (tt "3"))
    (hbl-append 0 (letk) (function "check ") (equal) (tt "GetNeighbours ") (keyword ">> ") (tt "FWU ") (keyword ">> ") (tt "CheckForThree") )))))

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
