// 5. String manipulation
var text = "The quick brown fox jumps over the lazy dog";

print("Original: " + text);
print("Length: " + text.length);
print("UpperCase: " + text.toUpperCase());
print("Substring (4, 9): " + text.substring(4, 9));
print("Index of 'fox': " + text.indexOf("fox"));

var parts = text.split(" ");
print("Split by space: " + parts.length + " words");
print("First word: " + parts[0]);
