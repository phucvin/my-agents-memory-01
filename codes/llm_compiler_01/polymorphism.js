var rect = {type: 1, w: 10, h: 20};
var circle = {type: 2, r: 5};
function area(s) {
  if (s.type === 1) return s.w * s.h;
  if (s.type === 2) return 3 * s.r * s.r; // pi=3
  return 0;
}
print(area(rect));
print(area(circle));
