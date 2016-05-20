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

##### Iterators
The iterator loops are cleaner and clearer to read and access all kinds of collections. Speed wise, it may be same or better than the for loops.
```
Iterator<T> iter = collection.iterator();
while (iter.hasNext()) {
  T obj = iter.next();
  // Code
}
```

##### LinkedList Vs ArrayList
Both ArrayList and LinkedList are implementation of List interface. Both these classes are non-synchronized and can be made synchronized explicitly by using Collections.synchronizedList method. They both maintain the elements insertion order.

|                   | LinkedList    | ArrayList     |
| ----------------- |:-------------:| -------------:|
| Search Speed      | O(n)          | O(1)          |
| Add/Delete        | O(1)          | O(n)          |
| Memory Overhead   | High          | Low           |

LinkedList and PriorityQueue are 2 implementations of the Queue collection interface.
LinkedList and ArrayDeque are the 2 implementaion of the Deque (Double Ended Queue) collection interface.

####CheckStyle:
https://github.com/checkstyle/checkstyle/blob/master/src/main/resources/google_checks.xml
