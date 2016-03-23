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

##### ByteBuffer
Good link http://www.kdgregory.com/index.php?page=java.byteBuffer

http://tutorials.jenkov.com/ is good site for java tutorials

#### Map* packages differences
HashMap is implemented as a hash table, and there is no ordering on keys or values. HashMap doesn't allow two identical keys.
Hashtable is synchronized, in contrast to HashMap. It has an overhead for synchronization.
TreeMap is implemented based on red-black tree structure, and it is ordered by the key. key object needs to have compareTo() method for this ordering. String class already has the compareTo() method. If we create our object for key, then it needs to implement compareTo() method.
LinkedHashMap preserves the insertion order and is a subclass of HashMap.

|                  | HashMap      | Hashtable     | TreeMap           | LinkedHashMap       |
| ---------------- |:------------:| -------------:| -----------------:|--------------------:|
| Insertion Order  | No           | No            | Yes               | Yes                 |
| null key-value   | Yes-Yes      | No-No         | No-Yes            | Yes-Yes             |
| Thread-Safe      | No           | Yes           | No                | No                  |
| Time Performance | O(1)         | O(1)          | O(log n)          | O(1)                |
| Implementation   | buckets      | buckets       | red-black tree    | doubly-linked-list  |


