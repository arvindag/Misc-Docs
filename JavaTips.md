#### String* packages differences
String object is immutable whereas StringBuffer and StringBuilder objects are mutable.
StringA = StringA + StringB will create a new object for StringA even though the name as same as it is immutable. String is immutable and final in Java and every modification is String result creates a new String object. This not not good for performance. You can convert a StringBuffer into String by its toString() method.

StringBuffer and StringBuilder objects are immutable and has efficient append. 
StringBuffer is synchronized which means it is thread safe and hence you can use it when you implement threads for your methods.
StringBuilder is not synchronized which implies it isn’t thread safe, but is substantially faster than StringBuffer.

|               | String                | StringBuffer        | StringBuilder       |
| ------------- |:---------------------:| -------------------:| -------------------:|
| Storage Area  | Constant String Pool  | Heap                | Heap                | 
| Modifiable    | No (immutable)        |   Yes (mutable)     | Yes (mutable)       |
| Thread-Safe   | Yes                   |    Yes              | No                  |
| Performance   | Fast                  | Very Slow           | Fast                |
