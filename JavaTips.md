#### String* packages differences
String object is immutable whereas StringBuffer and StringBuilder objects are mutable.
StringA = StringA + StringB will create a new object for StringA even though the name as same as it is immutable. This not not good for
performance.

StringBuffer and StringBuilder objects are immutable and has efficient append. 
StringBuffer is synchronized which means it is thread safe and hence you can use it when you implement threads for your methods.
StringBuilder is not synchronized which implies it isn’t thread safe.
