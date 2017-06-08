#### 1 Tutorial
##### 1.3 
Printf has overadozen such conversions, which Go programmers cal l verb s. This table is far
from a complete specification but illustrates many of the features that are available:
```
%d decimal integer
%x, %o, %b integer in hexadecimal, octal, binary
%f, %g, %e floating-point number: 3.141593 3.141592653589793 3.141593e+00
%t boolean: true or false
%c rune (Unicode code point)
%s string
%q quot ed str ing "abc" or rune 'c'
%v any value in a natural format
%T type of any value
%% literal percent sign (no operand)
%#v includes struct field names using Go syntax
%*s prints the string padded with variable number of spaces
```
A **map** is a reference to the data structure created by make. When a map is passed to a function,
the function receives a copy of the reference, so any changes the called function makes to
the underlying data structure will be visible through the caller’s map reference too. In our
example, the values inserted into the counts map by countLines are seen by main.
##### 1.6
A **goroutine** is a concurrent function execution. A **channel** is a communication mechanism
that allows one goroutine to pass values of a specified type to another goroutine. The function
main runs in a goroutine and the go statement creates additional goroutines.
##### 1.7 A web server
The server has two handlers, and the request URL determines which one is called: a request
for /count invokes counter and all others invoke handler. A handler pattern that ends with
a slash matches any URL that has the pattern as aprefix. Behind the scenes, the server runs
the handler for each incoming request in a separate goroutine so that it can serve multiple
requests simultaneously.
##### 1.8 Loose Ends
Cases do not fall through from one to thenext as in C-like languages (though there is a rarely 
used **fallthrough** statement that overrides this behavior).
A switch does not need an operand; it can just list the cases, each of which is a boolean
expression: This form is called a **tagless switch**; it’s equivalent to switch true.
#### 2 Program Structure
##### 2.2 Declerations
There are 4 major kinds of declarations: *var, const, type and func*.
##### 2.3 Variables
A *var* declaration creates a variable of a particular type, attached a name to it, and sets its
initial value. Each declaration has the general form *var name type = expression*.
###### 2.3.1 Short variable declaration
*name := expression*
Keep in mind that *:=* is a declaration and *=* is an assignment.
A short variable declaration does not necessarily *declare* all the variables on its left hand side. If some
of them were already declared in the same lexical block, then the short variable decleration acts like an
*assignment* to those variables. A short variable declaration must declare at least one new variable.
###### 2.3.2 Pointers
A variable is a piece of storage containing a value. A *pointer* is the address of a variable. Pointers
are comparable; two pointers are equal iff they point to the same variable or they are both nil. it is perfectly
safe for a function to return the address of a local variable.
```
v := 1
p := &v
*p is same as v
```
Pointer aliasing is useful because it allows us to access a variable without using its name. Pointers are key to 
the *flag* package, which uses a program's command-line arguments to set the values of certain variables distributed
throught the program.
```
var n = flag.Bool("n", false, "omit trailing newline")
var sep = flag.String("s", " ", "separator")
```
The variables *sep* and *n* are pointers to the flag variables, which must be accessed indirectly as *\*sep* and *\*n*.

###### 2.3.3 The new Function
Another way to create a variable is to use the built-in function *new*. The expression **new(T)** creates an *unnamed variable* 
of type T, initializes it to zero values of T, and returns its address, which is a value of type *\*T*. Each call to new returns
a distinct variable with a unique address.
Since *new* is a predeclared function, and **not a keyword**, it is possible to **redefine** the name for something else within a function.

###### 2.3.4 Lifetime of a variable
The variable lives on until it becomes **unreachable**, at which point its storage might be recycled.
```
var global *int
func f() {
  var x int
  x = 1
  global = &x
 }

func g() {
  y := new(int)
  *y = 1
}
```
Here, **x** must be **heap-allocated** because it is still reachable from the variable *global* after **f** has returned, despite
being declared as a local variable; we say **x** *escapes* from **f**. Conversely, when **g** returns, the variable **\*y** becomes
unreachable and can be recycled.

##### 2.5 Type Declarations
A **type** declaration defines a new *named type* that has the same *underlying type* as an existing type. The named type provides
a way to separate different and perhaps incompatible uses of the underlying type so that they cannot be mixed unintentionally.
```
type name underlying-type
```
```
type Celsius float64
type Fahrenheit float64
```
The above example defines two types, **Celsius** and **Fahrenheit**, for the two temperature. Even though both have the same
underlying types, *float64*, they are not the same type, so they **cannot be compared or combined** in arithmetic expressions. This 
stops inadvertent errors. An explicit type *conversion* like **Celsius(t)** or **Fahrenheit(t)** is required to convert from
a float64. **Celsius(t)** and **Fahrenheit(t)** are conversions, not function calls.
A conversion from one type to another is allowed if both have the same underlying type, or if both are unnamed pointer types
that point to variables of the same underlying type. These conversions change the type but not the representation of the value.
In any case, a type conversions never fails at run time. Some special conversions might changed the representation of of the value like float64 to int conversion or string to []byte slice conversions.
Named types also make it possible to define new behaviors for the values of the type. These behaviors are expressed as a set
of functions associated with the type, called the type's *methods*.

###### 2.6.2 Package Initialization
If the package has multiple .go files, they are initialized in the order in which the files are given to the compiler.
The go tool sorts the .go files by name before invoking the compiler.
```
func init() { /* ... */ }
```
Such **init()** functions can't be called or referenced, but otherwise they are normal functions. Within each file,
**init** functions are automatically executed when the program starts, in the order in which they are declared.

##### 2.7 Scope
Don't confuse scope with lifetime. The scope of the declaration is a region of the program text; it is a compile time
property. The lifetime of a variable is the range of time during execution when the variable can be referred to by other
parts of the program. It is a run time property.

#### 3 Basic Data Types
Go types fall into 4 categories: *basic types, aggregate types, reference types and interface types*.
**Basic** types like numbers, strings, booleans
**Aggregate** types like arrays and structs
**Reference** types includes pointers, slices, maps, functions, channels
##### 3.1 Integers
*int* is by far the most used integer type which is signed integer.
*rune* is a synonym for **int32** and indicates a value is a Unicode code point.
Similarly *byte* is a synonym for uint8
*uintptr* is suficient to hold all bits of a pointer value used only for low level programming.
Built-in **len** function returns a signed int so that it can be used in the loops.
Octal numbers seem to be used for exactly one purpose - file permissions on the POSIX systems.




