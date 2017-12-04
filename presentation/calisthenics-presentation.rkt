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
               (tt "    let rec FindNeighbours neighbours U =")
               (tt "        match neighbours with")
               (tt "        | [] -> U")
               (tt "        | H::T ->")
               (tt "            FindNeighbours T (")
               (tt "                 { x = cell.x + fst H;")
               (tt "                 y = cell.y +  snd H}")
               (tt "                :: U)")
               (tt "    FindNeighbours neighbours []")
               (hbl-append 0 (tt "    ") (keyword "|> ") (tt "List.rev"))))
   ((vonly withnames)
    (vl-append 0
               (hbl-append 0 (keyword "let ") (function "AddNeighbour ") (parameter "cell universe mods ") (keyword "="))
               (tt "    { x = cell.x + fst mods;")
               (tt "      y = cell.y +  snd mods}")
               (tt "    :: universe")
               (tt "")
               (hbl-append 0 (keyword "let ") (function "GetNeighbours") (parameter " (cell:Cell) : List<Cell> ") (keyword "="))
               (tt "    let rec FindNeighbours Ns U =")
               (tt "        match Ns with")
               (tt "        | [] -> U")
               (tt "        | H::T ->")
               (tt "            FindNeighbours T (AddNeighbour cell U H)")
               (tt "    FindNeighbours neighbours []")
               (tt "    |> List.rev"))))))

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
    (tt "let FindOnUniverse universe (alive:byref<_>) = ")
    (tt "    alive <- some_calculation")
    (tt " ")
    (tt "let CheckIfAlive cell universe =")
    (tt "    let mutable alive  = GetNeighbours cell")
    (tt "    FindOnUniverse universe &alive")
    (tt "    (List.length alive) = 2")
    (tt "    || (List.length alive = 3)")))
  (list
   (vl-append
    0
    (tt "let FindOnUniverse universe alive = ...")
    (tt " ")
    (tt "let CheckIfAlive cell universe =")
    (tt "    let neighbours  = GetNeighbours cell")
    (tt "    let alive = FindOnUniverse universe neighbours")
    (tt "    (List.length alive) = 2")
    (tt "    || (List.length alive = 3)")))))

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
    (tt "match CheckIfAlive elem universe with")
    (tt "| true -> printf \"hey\"")))
  (list
   (vl-append 0
    (tt "match CheckIfAlive elem universe with")
    (tt "| true -> elem :: acc")
    (tt "| false -> acc")))
  (list
   (vl-append 0
              (tt "if x = \"fefe\" then")
              (tt "    printf \"hey\"")))
  (list
   (vl-append 0
              (tt "if x = \"fefe\" then")
              (tt "    printf \"hey\"")
              (tt  "else")
              (tt  "    prinft \"ho\"")))))

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
    (tt "let ``Empty cell becomes alive`` () =")
    (tt "    let u3 = [")
    (tt "        { x = -1; y = -1};")
    (tt "        { x = 1; y = 1};")
    (tt "        { x = -1; y = 1}]")
    (tt "    let u = [{ x = 0; y = 0}]")
    (tt "    let au = NextUniverse u3")
    (tt "    Assert.True (CompareList u au)")))
  (list
   (vl-append
    0
    (tt "let expectedUniverse =")
    (tt "     [{ x = 0; y = 0}]")
    (tt "")
    (tt "let CompareWith expected actual =")
    (tt "    Assert.True (CompareList expected actual)")
    (tt "")
    (tt "let universeWithThreeCells = ")
    (tt "    [{ x = -1; y = -1};")
    (tt "     { x = 1; y = 1};")
    (tt "     { x = -1; y = 1}]")
    (tt "let ``Empty cell becomes alive`` () =")
    (tt "    universeWithThreeCells")
    (tt "    |> NextUniverse")
    (tt "    |> CompareWith expectedUniverse")))))

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
    (tt "let AddN cell mods universe =")
    (tt "    { x = cell.x + fst mods;")
    (tt "      y = cell.y +  snd mods}")
    (tt "    :: universe")
    (tt "")
    (tt "let GetNeighbours (cell:Cell) : List<Cell> =")
    (tt "    let rec FindNeighbours cU nU =")
    (tt "        match cU with")
    (tt "        | [] -> nU")
    (tt "        | H::T ->")
    (tt "            FindNeighbours T (AddN cell H nU)")
    (tt "    FindNeighbours neighbours []")
    (tt "    |> List.rev")))
  (list
   (vl-append 0
         (tt "let AddN cell mods universe =")
         (tt "    { x = cell.x + fst mods;")
         (tt "      y = cell.y +  snd mods}")
         (tt "    :: universe")
         (tt "")
         (tt "let GetNeighbours (cell:Cell) : List<Cell> =")
         (tt "    let AddNForCell acc elem = AddN cell elem acc")
         (tt "    List.fold AddNForCell [] neighbours")
         (tt "    |> List.rev")))))

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
    (tt "let NotIn universe =")
    (tt "    fun x -> not (List.exists (fun(y) -> CompareCell x y) universe)")
    (tt "")
    (tt "let NotAnyInUniverse universe from =")
    (tt "    List.filter (NotIn universe) from")
    (tt "")
    (tt "let Born universe =")
    (tt "    List.fold (fun acc elem ->")
    (tt "                   (GetNeighbours elem) @ acc) [] universe)")
    (tt "    |> Set.ofList")
    (tt "    |> Set.toList")
    (tt "    |> NotAnyInUniverse ")
    (tt "    |> List.fold (fun acc elem ->")
    (tt "                  match CheckIfThree elem universe with")
    (tt "                  | true -> elem :: acc")
    (tt "                  | false -> acc) []")))
  (list
   (vl-append
    0
    (tt "let NotIn list =")
    (tt "    fun x -> not (List.exists (fun(y) -> CompareCell x y) list)")
    (tt "")
    (tt "let NotAnyIn list from =")
    (tt "    List.filter (NotIn list) from")
    (tt "")
    (tt "let Born check universe =")
    (tt "    List.fold (fun acc elem ->")
    (tt "                   (GetNeighbours elem) @ acc) [] universe)")
    (tt "    |> Set.ofList")
    (tt "    |> Set.toList")
    (tt "    |> NotAnyIn universe")
    (tt "    |> List.fold (fun acc elem ->")
    (tt "                  match check elem universe with")
    (tt "                  | true -> elem :: acc")
    (tt "                  | false -> acc) []")
    (tt "")
    (tt "let BornWithThree universe =")
    (tt "    Born CheckIfThree universe")
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
    (tt "let FindOnUniverse list1 list2 =")
    (tt "    List.filter ")
    (tt "        (fun (x) ->")
    (tt "            List.exists (fun(y) -> x = y) list2)")
    (tt "        list1")))
  (list
   (vl-append
    0
    (tt "let FindOnUniverse seq1 seq2 =")
    (tt "    Seq.filter")
    (tt "        (fun (x) ->")
    (tt "            Seq.exists (fun(y) -> x = y) seq2)")
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
    (tt "let FindOnUniverse list1 list2 =")
    (tt "    List.filter")
    (tt "        (fun (x) -> ")
    (tt "            List.exists (fun(y) -> x = y) list2)")
    (tt "        list1")))
  (list
   (vl-append
    0
    (tt "let CheckForExistence onList =")
    (tt "    fun(x) -> List.exists (fun(y) -> x = y) onList")
    (tt "")
    (tt "let Find possibles = ")
    (tt "    List.Filter (CheckForExistence universe) possibles")))
  (list
   (vl-append
    0
    (tt "let CheckIfThree cell universe =")
    (tt "    let neighbours = GetNeighbours cell")
    (tt "    let alive = FindOnUniverse universe neighbours")
    (tt "    List.length alive = 3")))
  (list
   (vl-append
    0
    (tt "let FWU = FindOnUniverse universe")
    (tt "let checkForThree alive = List.length alive = 3")
    (tt "let check = GetNeighbours >> FWU >> checkForThree")))))

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
