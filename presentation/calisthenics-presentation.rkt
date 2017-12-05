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
 (wrapper (t "ta")))

(slide
 (comment "Now that I have a context you know that 'taka' has to do with an attacking pattern. At some speed 'ta' is not good enough. The movement of the tongue is too slow to keep pace. The 'ka' attacking pattern represents the use of your laringe to cut and restart the air flow. And you do require quite some practice to master it.")
 (rb-superimpose
  (cc-superimpose
   (linewidth 0 (frame (blank client-w client-h) #:color "white"))
   (t "taka"))
  (bitmap "footer-logo.png")) )

(slide
 (comment "Now you have the information about what the above represents. Both the how and why (physical movement and speed). Again, this requires a lot of practice. As a professional trumpet player you will go through this everyday. Scales, arpegios, études ...")
 (rb-superimpose
  (cc-superimpose
   (linewidth 0 (frame (blank client-w client-h) #:color "white"))
   (t "tataka"))
  (bitmap "footer-logo.png")))

(slide
 (rb-superimpose
  (cc-superimpose
   (linewidth 0 (frame (blank client-w client-h) #:color "white"))
   (t "Practice makes the master"))
  (bitmap "footer-logo.png")))

(with-steps
 (intro first second third)
 (slide
  #:title "The Clojure Experiment"
   (vc-append gap-size
              ((vafter first)
               (t "First functional production code"))
              ((vafter second) (t "Back to well trained imperative patterns"))
              ((vafter third) (t "The code was a mess")))
  (comment "I like functional programming. I have done functional programming at home. Testing things here and there. I have used F#. I have use Clojure. I have used Elixir. But ... all what I did was small pieces of code under no pressure. At Codurance I had the opportunity of working on my first production functional code. And soon I found myself, as the deadlines was looming, back into my well trained OO and imperative programming. On one side, it did allow me to move quickly. On the other side, the resulting code was a mess. Difficult to understand and difficult to change. At the end I came to realize that all that practicing that I have done for my OOP skills needed to be replicated on FP.")))

(slide
 #:title "Functional Calisthenics"
 (comment "Which is were Functional Calisthenics come into play. They were originally set at Socrates UK 2015. I decided to have a stab at them. But there were a few rules that I disagree with, and sadly there was missing something I considered important: Why?. So we got together a group of developers at Codurance and rewrote them. They are not a finished job. And we are not the owners of the truth. I will explain why we have each one. But I will happily stand corrected if that means improving my craft.")
 'next
 (t "Original version during Socrates UK 2015")
 'next
 (t "First stab led to rewrite")
 'next
 (t "A job in progress"))

(slide
 #:title "The application"
 (comment "All what I am going to send is for practice. What you do on production code will depend. Because not all functional languages are equal. They have different characteristics. For example, I remember a presentation by Phil (Trelford) about the use of mutable collections on F# for performance purposes. Furthermore, some of the rules are either forced into you by the language (for example, Haskell forces a few of these rules). Or are simply not possible (the pipe operator or currying in Erlang for the rule \"Do not use intermediate variables\")")
 'next
 (t "This is for practice")
 'next
 (t "Each functional language has its own characteristics"))

(slide
 #:title "The Rules"
 (comment "These are the rules as they currently stand. We will be looking at examples of each one as we move along.")
 (item "Name everyting")
 (item "No Mutable State")
 (item "Exhaustive Conditionals")
 (item "Do Not Use Intermediate Variables")
 (item "No Explicit Recursion")
 (item "Generic Building Blocks")
 (item "Side Effects At The Boundaries")
 (item "Expressions, Not Statemets")
 (item "Infinite Sequences")
 (item "One Argument Functions"))

(slide
 #:title "Conway's Game of life"
 (comment "Does anyone not know the game of life? Created in 1970 by John Horton Conway. Interesting because from a very simple set of rules you can create some sofisticated elements. When I originally heard about it I learned about gliders, and guns, and oscillators. And then, not long ago I discovered that you can create an Universal Turing Machine from it.")
 'next
 (item "Cells are alive or dead")
 (item "Universe is a grid of squares")
 (item "Cell stays alive if 2 or 3 neighbours")
 (item "Dead cell will born if 3 neighbours"))

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
               (hbl-append 0 (keyword "let ") (function "GetNeighbours") (parameter " (cell:Cell) : List<Cell> ") (keyword "="))
               (hbl-append 0 (tt "    ") (keyword "let rec ") (function "FindNeighbours ") (parameter " neighbours U ") (keyword "="))
               (hbl-append 0 (tt "        ") (keyword "match ") (tt "neighbours ") (keyword "with"))
               (hbl-append 0 (tt "        ") (keyword "| ") (keyword "[] -> ") (tt "U"))
               (hbl-append 0 (tt "        ") (keyword "| ") (tt "H") (keyword "::") (tt "T ") (keyword "->"))
               (tt "            FindNeighbours T (")
               (hbl-append 0 (tt "                 ") (keyword "{ ") (tt "x ") (keyword "= ") (tt "cell.x ") (keyword "+ ") (tt "fst H") (keyword ";"))
               (hbl-append 0 (tt "                 y ") (keyword "= ") (tt "cell.y ") (keyword "+ ") (tt "snd H") (keyword "}"))
               (hbl-append 0 (tt "                ") (keyword ":: ") (tt "U)"))
               (tt "    FindNeighbours neighbours []")
               (hbl-append 0 (tt "    ") (keyword "|> ") (tt "List.rev"))))
   ((vonly withnames)
    (vl-append 0
               (hbl-append 0 (keyword "let ") (function "AddNeighbour ") (parameter "cell universe mods ") (keyword "="))
               (hbl-append 0 (keyword "    { ") (tt "x ") (keyword "= ") (tt "cell.x ") (keyword "+ ") (tt "fst mods") (keyword ";"))
               (hbl-append 0 (tt "      y ") (keyword "= ") (tt "cell.y ") (keyword "+ ") (tt "snd mods") (keyword "}"))
               (hbl-append 0 (keyword "    ::") (tt "universe"))
               (tt "")
               (hbl-append 0 (keyword "let ") (function "GetNeighbours") (parameter " (cell:Cell) : List<Cell> ") (keyword "="))
               (hbl-append 0 (keyword "    let rec ") (function "FindNeighbours") (parameter "Ns U ") (keyword "="))
               (hbl-append 0 (keyword "        match ") (tt "Ns ") (keyword "with"))
               (hbl-append 0 (keyword "        | [] -> ") (tt "U"))
               (hbl-append 0 (keyword "        | ") (tt "H") (keyword "::") (tt "T ") (keyword "->"))
               (tt "            FindNeighbours T (AddNeighbour cell U H)")
               (hbl-append 0 (tt "    FindNeighbours neighbours ") (keyword "[]"))

               (hbl-append 0 (keyword "    |> ") (tt "List.rev")))))))

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
    (hbl-append 0 (keyword "let ") (function "FindOnUniverse ") (parameter "universe alive") (keyword "= ") (tt "..."))
    (tt " ")
    (hbl-append 0 (keyword "let ") (function "CheckIfAlive ") (parameter "cell universe ") (keyword "="))
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
    (hbl-append 0 (tab) (letk) (function "universe ") (equal) (keyword "[{ ") (tt "x ") (equal) (tt "0") (keyword "; ") (tt "y ") (equal) (tt "0") (keyword "}]"))
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
    (hbl-append 0 (tab) (keyword "{") (tt "x ") (equal) (tt "1") (keyword "; ") (tt "y ") (equal) (tt "1") (keyword "};"))
    (hbl-append 0 (tab) (keyword "{") (tt "x ") (equal) (tt "-1") (keyword "; ") (tt "y ") (equal) (tt "1") (keyword "}]"))
    (hbl-append 0 (tab) (keyword "|> ") (tt "NextUniverse"))
    (hbl-append 0 (tab) (keyword "|> ") (tt "CompareWith ") (keyword "[{ ") (tt "x ") (equal) (tt "0") (keyword "; ") (tt "y ") (equal) (tt "0") (keyword "}]"))))
  (list
   (vl-append
    0
    (hbl-append 0 (letk) (function "CompareWith ") (parameter "expected actual ") (equal))
    (tt "    Assert.True (CompareList expected actual)")
    (tt "")
    (hbl-append 0 (letk) (function "expectedUniverse ") (equal))
    (hbl-append 0 (tab) (keyword "[{ ") (tt "x ") (equal) (tt "0") (keyword "; ") (tt "y ") (equal) (tt "0") (keyword "}]"))
    (tt "")
    (hbl-append 0 (letk) (function "universeWithThreeCells ") (equal))
    (hbl-append 0 (tab) (keyword "[{") (tt "x ") (equal) (tt "-1") (keyword "; ") (tt "y ") (equal) (tt "-1") (keyword "};"))
    (hbl-append 0 (tab) (keyword "{") (tt "x ") (equal) (tt "1") (keyword "; ") (tt "y ") (equal) (tt "1") (keyword "};"))
    (hbl-append 0 (tab) (keyword "{") (tt "x ") (equal) (tt "-1") (keyword "; ") (tt "y ") (equal) (tt "1") (keyword "}]"))
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
    (hbl-append 0 (tab) (keyword "{ ") (tt "x ") (equal) (tt "cell.x ") (keyword "+ ") (tt "fst mods") (keyword ";"))
    (hbl-append 0 (tab) (tt "y ") (equal) (tt "cell.y ") (keyword "+ ") (tt "snd mods") (keyword "}"))
    (hbl-append 0 (tab) (keyword ":: ") (tt "universe"))
    (tt "")
    (hbl-append 0 (letk) (function "GetNeighbours ") (parameter "(cell:Cell) : List<Cell> ") (equal))
    (hbl-append 8 (tab) (letk) (keyword "rec ") (function "FindNeighbours ") (parameter "U N ") (equal))
    (hbl-append 0 (tab) (tab) (keyword "match ") (tt "N ") (keyword "with "))
    (hbl-append 0 (tab) (tab) (keyword "| [] -> ") (tt "U"))
    (hbl-append 0 (tab) (tab) (keyword "| ") (tt "H") (keyword "::") (tt "T ") (keyword "->"))
    (tt "            FindNeighbours T (AddN cell U H)")
    (hbl-append 0 (tt "    FindNeighbours neighbours ") (keyword "[]"))
    (hbl-append 0 (tab) (keyword "|>") (tt "List.rev"))))
  (list
   (vl-append
    0
    (hbl-append 0 (letk) (function "AddN ") (parameter "cell universe mods ") (equal))
    (hbl-append 0 (tab) (keyword "{ ") (tt "x ") (equal) (tt "cell.x ") (keyword "+ ") (tt "fst mods") (keyword ";"))
    (hbl-append 0 (tab) (tt "y ") (equal) (tt "cell.y ") (keyword "+ ") (tt "snd mods") (keyword "}"))
    (hbl-append 0 (tab) (keyword ":: ") (tt "universe"))
    (tt "")
    (hbl-append 0 (letk) (function "GetNeighbours ") (parameter "(cell:Cell) : List<Cell> ") (equal))
    (hbl-append 0 (tab) (letk) (function "AddNForCell ") (parameter "acc elem ") (equal) (tt "AddN cell acc elem"))
    (hbl-append 0 (tab) (tt "List.fold (AddN cell) ") (keyword "[] ") (tt "neighbours"))
    (hbl-append 0 (tab) (keyword "|>") (tt "List.rev"))))
  (list
   (vl-append
    0
    (hbl-append 0 (letk) (function "AddN ") (parameter "cell universe mods ") (equal))
    (hbl-append 0 (tab) (keyword "{ ") (tt "x ") (equal) (tt "cell.x ") (keyword "+ ") (tt "fst mods") (keyword ";"))
    (hbl-append 0 (tab) (tt "y ") (equal) (tt "cell.y ") (keyword "+ ") (tt "snd mods") (keyword "}"))
    (hbl-append 0 (tab) (keyword ":: ") (tt "universe"))
    (tt "")
    (hbl-append 0 (letk) (function "GetNeighbours ") (parameter "(cell:Cell) : List<Cell> ") (equal))
    (hbl-append 0 (tab) (tt "List.fold (AddN cell) ") (keyword "[] ") (tt "neighbours"))
    (hbl-append 0 (tab) (keyword "|>") (tt "List.rev"))))))

(slide
 #:title "Generic Building Blocks"
 (comment "The Born function is very aware of the domain in which it is working. Its even aware of the fact that is a Life of game on a square's grid. But what if we wanted to use an hexagonal grid? The rule for being born is different (2 neighbours, instead of 3). ")
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
    (hbl-append (letk) (function "BornWithThree ") (parameter "universe ") (equal))
    (tt "    Born CheckIfThree universe")))))

(slide
 #:title "Side effects at the boundaries"
 (t "Keep your functions pure")
 'next
 'alts
 (list
  (list
   (vl-append
    0
    (tt "let CreateUniverse () = ")
    (tt "    printf \"We are creating the universe\"")
    (tt "    [{x = 0; y = 0}]")))
  (list
   (vl-append
    0
    (tt "let CreateUniverse logger = ")
    (tt "    logger \"We are creating the universe\"")
    (tt "    [{x = 0; y = 0}]")))
  (list
   (vl-append
    0
    (tt "let CreateUniverse logger = ")
    (tt "    [{x = 0; y = 0}]")
    (tt "")
    (tt "let [<EntryPoint>] main _ = ")
    (tt "   printf \"We are creating the universe\"")
    (tt "   [{x = 0; y = 0}]")))))

(slide
 #:title "Expressions, not Statements"
 (comment "This started as a rule. But after using the rules of no mutable state and side effects on the boundaries there shouldn't be anything to apply here. Expressions, not Statmentes becomes a property of your code.")
 'next
 (t "No assignment at any point."))

(slide
 #:title "Infinite Sequences"
 'next
 (t "Don't use fixed sized collections")
 'next
 (t "Don't depend on the lenght of the collection")
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
