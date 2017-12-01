#lang slideshow

(require slideshow/code)
(require slideshow/step)

(define (code-line line)
  (para #:align 'left (tt line)))

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
 (t "Name everything")
 (t "No Mutable State")
 (t "Name everything")
 (t "Name everything")
 (t "Name everything")
 (t "Name everything")
 (t "Name everything")
 (t "Name everything")
 (t "Name everything")
 (t "Name everything"))

(slide
 #:title "Name Everything"
 'next
 (t "Everything should have a name")
 'next
 (t "(Including lambdas/anonymous functions)")
 'next
 'alts
 (list
  (list
   (vl-append 0
         (code-line "let GetNeighbours (cell:Cell) : List<Cell> =")
         (code-line "    List.fold (fun acc elem ->")
         (code-line "        { xPosition = cell.xPosition + fst elem;")
         (code-line "          yPosition = cell.yPosition +  snd elem}")
         (code-line "       :: acc)")
         (code-line "    [] neighbours")
         (code-line "    |> List.rev")))
  (list
   (vl-append 0
         (code-line "let AddNeighbour cell mods universe =")
         (code-line "    { xPosition = cell.xPosition + fst mods;")
         (code-line "      yPosition = cell.yPosition +  snd mods}")
         (code-line "    :: universe")
         (code-line "")
         (code-line "let GetNeighbours (cell:Cell) : List<Cell> =")
         (code-line "    let AddNeighbourForCell acc elem = AddNeighbour cell elem acc")
         (code-line "    List.fold AddNeighboursForCell [] neighbours")
         (code-line "    |> List.rev")))))

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
    (code-line "let FindOnUniverse universe (alive:byref<_>) = ")
    (code-line "    alive <- some_calculation")
    (code-line " ")
    (code-line "let CheckIfAlive cell universe =")
    (code-line "    let mutable alive  = GetNeighbours cell")
    (code-line "    FindOnUniverse universe &alive")
    (code-line "    (List.length alive) = 2")
    (code-line "    || (List.length alive = 3)")))
  (list
   (vl-append
    0
    (code-line "let FindOnUniverse universe alive = ...")
    (code-line " ")
    (code-line "let CheckIfAlive cell universe =")
    (code-line "    let neighbours  = GetNeighbours cell")
    (code-line "    let alive = FindOnUniverse universe neighbours")
    (code-line "    (List.length alive) = 2")
    (code-line "    || (List.length alive = 3)")))))

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
   (vl-append 0
    (code-line "match CheckIfAlive elem universe with")
    (code-line "| true -> printf \"hey\"")))
  (list
   (vl-append 0
    (code-line "match CheckIfAlive elem universe with")
    (code-line "| true -> elem :: acc")
    (code-line "| false -> acc")))
  (list
   (vl-append 0
              (code-line "if x = \"fefe\" then")
              (code-line "    printf \"hey\"")))
  (list
   (vl-append 0
              (code-line "if x = \"fefe\" then")
              (code-line "    printf \"hey\"")
              (code-line  "else")
              (code-line  "    prinft \"ho\"")))))

(slide
 #:title "Do not use intermediate variables"
 (comment "")
 'next
 (t "It is about the flow of data transformations")
 'next
 'alts
 (list
  (list
   (vl-append
    0
    (code-line "let ``Empty cell becomes alive`` () =")
    (code-line "    let u3 = [")
    (code-line "        { xPosition = -1; yPosition = -1};")
    (code-line "        { xPosition = 1; yPosition = 1};")
    (code-line "        { xPosition = -1; yPosition = 1}]")
    (code-line "    let u = [{ xPosition = 0; yPosition = 0}]")
    (code-line "    let au = NextUniverse u3")
    (code-line "    Assert.True (CompareList u au)")))
  (list
   (vl-append
    0
    (code-line "let expectedUniverse =")
    (code-line "     [{ xPosition = 0; yPosition = 0}]")
    (code-line "")
    (code-line "let CompareExpected expectedUniverse actualUniverse =")
    (code-line "Assert.True (CompareList expectedUniverse actualUniverse)")
    (code-line "")
    (code-line "let universeWithThreeCells = ")
    (code-line "    [{ xPosition = -1; yPosition = -1};")
    (code-line "     { xPosition = 1; yPosition = 1};")
    (code-line "     { xPosition = -1; yPosition = 1}]")
    (code-line "let ``Empty cell becomes alive`` () =")
    (code-line "    universeWithThreeCells")
    (code-line "    |> NextUniverse")
    (code-line "    |> CompareWith expectedUniverse")))))

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
    (code-line "let GetNeighbours (cell:Cell) : List<Cell> =")
    (code-line "    let rec FindNeighbours cU nU =")
    (code-line "        match cU with")
    (code-line "        | [] -> nU")
    (code-line "        | H::T ->")
    (code-line "            FindNeighbours T (addNeigh cell H nU)")
    (code-line "    FindNeighbours neighbours []")
    (code-line "    |> List.rev")))
  (list
   (vl-append 0
         (code-line "let AddNeighbour cell mods universe =")
         (code-line "    { xPosition = cell.xPosition + fst mods;")
         (code-line "      yPosition = cell.yPosition +  snd mods}")
         (code-line "    :: universe")
         (code-line "")
         (code-line "let GetNeighbours (cell:Cell) : List<Cell> =")
         (code-line "    let AddNForCell acc elem = AddNeighbour cell elem acc")
         (code-line "    List.fold AddNForCell [] neighbours")
         (code-line "    |> List.rev")))))

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
    (code-line "let Born universe =")
    (code-line "    List.fold (fun acc elem ->")
    (code-line "                   (GetNeighbours elem) @ acc) [] universe)")
    (code-line "    |> Set.ofList")
    (code-line "    |> Set.toList")
    (code-line "    |> List.filter (fun x -> ")
    (code-line "                       not (List.exists")
    (code-line "                                (fun y -> CompareCell x y) universe)")
    (code-line "    |> List.fold (fun acc elem ->")
    (code-line "                  match CheckIfThree elem universe with")
    (code-line "                  | true -> elem :: acc")
    (code-line "                  | false -> acc) []")))
  (list
   (vl-append
    0
    (code-line "let Born check universe =")
    (code-line "    List.fold (fun acc elem ->")
    (code-line "                   (GetNeighbours elem) @ acc) [] universe)")
    (code-line "    |> Set.ofList")
    (code-line "    |> Set.toList")
    (code-line "    |> List.filter (fun x -> ")
    (code-line "                       not (List.exists")
    (code-line "                                (fun y -> CompareCell x y) universe)")
    (code-line "    |> List.fold (fun acc elem ->")
    (code-line "                  match check elem universe with")
    (code-line "                  | true -> elem :: acc")
    (code-line "                  | false -> acc) []")
    (code-line "")
    (code-line "let BornWithThree universe =")
    (code-line "    Born CheckIfThree universe")
    ))))

(slide
 #:title "Side effects at the boundaries"
 (t "Keep your functions pure")
 'next
 'alts
 (list
  (list
   (vl-append
    0
    (code-line "let CreateUniverse () = ")
    (code-line "    printf \"We are creating the universe\"")
    (code-line "    [{xPosition = 0; yPosition = 0}]")))
  (list
   (vl-append
    0
    (code-line "let CreateUniverse logger = ")
    (code-line "    logger \"We are creating the universe\"")
    (code-line "    [{xPosition = 0; yPosition = 0}]")))
  (list
   (vl-append
    0
    (code-line "let CreateUniverse logger = ")
    (code-line "    [{xPosition = 0; yPosition = 0}]")
    (code-line "")
    (code-line "let [<EntryPoint>] main _ = ")
    (code-line "   printf \"We are creating the universe\"")
    (code-line "   [{xPosition = 0; yPosition = 0}]")))))

(slide
 #:title "Expressions, not Statements"
 (comment "")
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
    (code-line "let FindOnUniverse list1 list2 =")
    (code-line "    List.filter ")
    (code-line "        (fun (x) ->")
    (code-line "            List.exists (fun(y) -> x = y) list2)")
    (code-line "        list1")))
  (list
   (vl-append
    0
    (code-line "let FindOnUniverse seq1 seq2 =")
    (code-line "    Seq.filter")
    (code-line "        (fun (x) ->")
    (code-line "            Seq.exists (fun(y) -> x = y) seq2)")
    (code-line "        seq1")))))

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
    (code-line "let FindOnUniverse list1 list2 =")
    (code-line "    List.filter")
    (code-line "        (fun (x) -> ")
    (code-line "            List.exists (fun(y) -> x = y) list2)")
    (code-line "        list1")))
  (list
   (vl-append
    0
    (code-line "let CheckForExistence onList =")
    (code-line "    fun(x) -> List.exists (fun(y) -> x = y) onList")
    (code-line "")
    (code-line "let Exists = CheckForExistence universe")
    (code-line "let Find possibles = ")
    (code-line "    List.Filter Exists possibles")))
  (list
   (vl-append
    0
    (code-line "let CheckIfThree cell universe =")
    (code-line "    let neighbours = GetNeighbours cell")
    (code-line "    let alive = FindOnUniverse universe neighbours")
    (code-line "    List.length alive = 3")))
  (list
   (vl-append
    0
    (code-line "let FWU = FindOnUniverse universe")
    (code-line "let checkForThree alive = List.length alive = 3")
    (code-line "let check = GetNeighbours >> FWU >> checkForThree")))))

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
