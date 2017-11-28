#lang slideshow

(require slideshow/code)

(slide
 (text "Functional Calisthenics" (current-main-font) 60)
 (t "Jorge Gueorguiev Garcia")
 (bitmap "codurance.png"))

(slide
 (t "ta")
 (comment "What is this? Without context there is no meaning. Or rather we are left to
create our meaning. If I put the context of trumpet playing, then 'ta' becomes the representation of the attacking pattern to start sound. As a student or profressional trumpet player you will practice this constantitly as part of your scales, arpegios and études."))

(slide
 (t "taka")
 (comment "Now that I have a context you know that 'taka' has to do with an attacking pattern. At some speed 'ta' is not good enough. The movement of the tongue is too slow to keep pace. The 'ka' attacking pattern represents the use of your laringe to cut and restart the air flow. And you do require quite some practice to master it."))

(slide
 (t "tataka")
 (comment "Now you have the information about what the above represents. Both the how and why (physical movement and speed). Again, this requires a lot of practice. As a professional trumpet player you will go through this everyday. Scales, arpegios, études ..."))

(slide
 (t "Practice makes the master"))

(slide
 #:title "The Clojure Experiment"
 'next
 (t "First functional production code")
 'next
 (t "Back to well trained imperative patterns")
 'next
 (t "The code was a mess")
 (comment "I like functional programming. I have done functional programming at home. Testing things here and there. I have used F#. I have use Clojure. I have used Elixir. But ... all what I did was small pieces of code here and there. At Codurance I had the opportunity of working on my first production functional code. And soon I found myself, as the deadlines was looming, back into my well trained OO and imperative programming. On one side, it did allow me to move quickly. On the other side, the resulting code was a mess. Difficult to understand and difficult to change. At the end I came to realize that all that practicing that I have done for my OOP skills needed to be replicated on FP."))

(slide
 #:title "Functional Calisthenics"
 'next
 (t "Original version during Socrates UK 2015")
 'next
 (t "First stab led to rewrite")
 (comment "Which is were Functional Calisthenics come into play. They were originally set at Socrates UK 2015. I decided to have a stab at them. But there were a few rules that I disagree with, and sadly there was missing something I considered important: Why?. So we got together a group of developers at Codurance and rewrote them."))

(slide
 #:title "Name Everything"
 (t "Everything should have a name")
 'next
 (t "(Including lambdas/anonymous functions)")
 'next
 'alts
 (list
  (list
   (para #:align 'left
         (tt "let GetNeighbours (cell:Cell) : List<Cell> =")
         (tt "    List.fold (fun acc elem ->")
         (tt "        { xPosition = cell.xPosition + fst elem;")
         (tt "          yPosition = cell.yPosition +  snd elem}")
         (tt "       :: acc)")
         (tt "    [] neighbours")
         (tt "    |> List.rev")))
  (list
   (para #:align 'left
         (t "new code")))))

(slide
 #:title "No Mutable State"
 (t "We are doing functional programming")
 'next
 'alts
 (list
  (list
   (para #:align 'left
         (tt "let CheckIfAlive cell universe =")
         (tt "    let mutable alive  = GetNeighbours cell")
         (tt "    alive <- FindOnUniverse universe alive")
         (tt "    (List.length alive) = 2")
         (tt "    || (List.length alive = 3)")))
  (list
   (para #:align 'left
         (t "new code")))))

(slide
 #:title "Exhaustive Conditionals"
 (t "All your ifs, matches, cases should be able")
 (t "to deal with all possible input")
 'next
 'alts
 (list
  (list
   (para #:align 'left
         (t "Original code")))
  (list
   (para #:align 'left
         (t "new code")))))

(slide
 #:title "Do not use intermediate variables"
 (t "Everything should have a name")
 'next
 (t "(Including lambdas/anonymous functions)")
 'next
 'alts
 (list
  (list
   (para #:align 'left 
         (tt "let ``Empty cell becomes alive`` () =")
         (tt "    let u3 = [")
         (tt "        { xPosition = -1; yPosition = -1};")
         (tt "        { xPosition = 1; yPosition = 1};")
         (tt "        { xPosition = -1; yPosition = 1}]")
         (tt "    let u = [{ xPosition = 0; yPosition = 0}]")
         (tt "    let au = NextUniverse u3")
         (tt "    Assert.True (CompareList u au)")))
  (list
   (para #:align 'left
         (t "new code")))))

(slide
 #:title "Expressions, not Statements"
 (t "No assignment at any point.")
 'next
 'alts
 (list
  (list
   (para #:align 'left
         (t "Original code")))
  (list
   (para #:align 'left
         (t "new code")))))

(slide
 #:title "No Explicit Recursion"
 (t "Map and Reduce should be used instead")
 'alts
 (list
  (list
   (para #:align 'left
         (tt "let GetNeighbours (cell:Cell) : List<Cell> =")
         (tt "    let rec FindNeighbours cU nU =")
         (tt "        match cU with")
         (tt "        | [] -> nU")
         (tt "        | H::T ->")
         (tt "            FindNeighbours T (addNeigh cell H nU)")
         (tt "    FindNeighbours neighbours []")
         (tt "    |> List.rev")))
  (list
   (para #:align 'left
         (t "new code")))))

(slide
 #:title "Generic Building Blocks"
 (t "Try to create functions that are not domain aware")
 'alts
 (list
  (list
   (para #:align 'left
         (t "Original code")))
  (list
   (para #:align 'left
         (t "new code")))))

(slide
 #:title "Side effects at the boundaries"
 (t "Keep your functions pure")
 'alts
 (list
  (list
   (para #:align 'left
         (t "Original code")))
  (list
   (para #:align 'left
         (t "new code")))))

(slide
 #:title "Infinite Sequences"
 (t "Don't use fixed sized collections")
 (t "Don't depend on the lenght of the collection")
 'alts
 (list
  (list
   (para #:align 'left
         (t "Original code")))
  (list
   (para #:align 'left
         (t "new code")))))

(slide
 #:title "One argument functions"
 (t "Functions should have a single argument")
 'alts
 (list
  (list
   (para #:align 'left
         (t "Original code")))
  (list
   (para #:align 'left)
   (t "new code"))))

(slide
 #:title "The Links"
 (t "Our take: https://codurance.com/2017/10/12/functional-calisthenics/")
 (t "The original: http://blog.ninjaferret.co.uk/2015/06/05/Introducing-Functional-Calisthenics.html")
 (t "Kata modifications: https://codurance.com/2017/11/16/katas-for-functional-calisthenics/"))

(slide
 #:title "The end"
 (t "Jorge Gueorguiev Garcia")
 (t "@yefoakira")
 (bitmap "codurance.png"))
