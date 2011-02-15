;; HelloWorld.ik
;; Damien
;; Some basic fucntion explonation

;; Var = input
;; MethodName = method("Documentation Information", Var1: DefaultVar1, Var2: DefaultVar1,
;;	Command1
;;	Command2
;;	)

;; List of Var
a = "moo"
b = " goes the"
c = "cow"
x = "boo"
y = " "
z = "World"

;; print commandline command with out put "moo goes the cow"
(a + b + c) println

;; HelloWorld method
HelloWorld = method(x: "Hello", y: " ", z: "World",
  (x + y + z) println)

;; Outputs the default settings "Hello World" to commandline
HelloWorld()

;; Outputs the "boo World" to commandline
HelloWorld(x: x, y: y, z: z)

;; Outputs the "moo  goes the cow" to commandline
HelloWorld(x: a, y: b, z: c)