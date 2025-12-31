function Result$Err$0$(param0) {
  this._0 = param0;
}
Result$Err$0$.prototype.$tag = 0;
function Result$Ok$0$(param0) {
  this._0 = param0;
}
Result$Ok$0$.prototype.$tag = 1;
const Error$moonbitlang$47$core$47$builtin$46$CreatingViewError$46$IndexOutOfBounds = { $tag: 1 };
const Error$moonbitlang$47$core$47$builtin$46$CreatingViewError$46$InvalidIndex = { $tag: 0 };
class $PanicError extends Error {}
function $panic() {
  throw new $PanicError();
}
const moonbitlang$core$builtin$$int_to_string_js = (x, radix) => {
  return x.toString(radix);
};
const moonbitlang$core$builtin$$JSArray$push = (arr, val) => { arr.push(val); };
const $$$64$moonbitlang$47$core$47$builtin$46$StringBuilder$36$as$36$64$moonbitlang$47$core$47$builtin$46$Logger = { method_0: moonbitlang$core$builtin$$Logger$write_string$0$, method_1: moonbitlang$core$builtin$$Logger$write_substring$1$, method_2: moonbitlang$core$builtin$$Logger$write_view$0$, method_3: moonbitlang$core$builtin$$Logger$write_char$0$ };
function moonbitlang$core$builtin$$Logger$write_object$2$(self, obj) {
  moonbitlang$core$builtin$$Show$output$2$(obj, self);
}
function moonbitlang$core$builtin$$StringBuilder$new$46$inner(size_hint) {
  return { val: "" };
}
function moonbitlang$core$builtin$$Logger$write_char$0$(self, ch) {
  const _bind = self;
  _bind.val = `${_bind.val}${String.fromCodePoint(ch)}`;
}
function moonbitlang$core$builtin$$Logger$write_string$0$(self, str) {
  const _bind = self;
  _bind.val = `${_bind.val}${str}`;
}
function moonbitlang$core$string$$String$sub$46$inner(self, start, end) {
  const len = self.length;
  let end$2;
  if (end === undefined) {
    end$2 = len;
  } else {
    const _Some = end;
    const _end = _Some;
    end$2 = _end < 0 ? len + _end | 0 : _end;
  }
  const start$2 = start < 0 ? len + start | 0 : start;
  if (start$2 >= 0 && (start$2 <= end$2 && end$2 <= len)) {
    let _tmp;
    if (start$2 < len) {
      const _p = self.charCodeAt(start$2);
      _tmp = 56320 <= _p && _p <= 57343;
    } else {
      _tmp = false;
    }
    if (_tmp) {
      return new Result$Err$0$(Error$moonbitlang$47$core$47$builtin$46$CreatingViewError$46$InvalidIndex);
    }
    let _tmp$2;
    if (end$2 < len) {
      const _p = self.charCodeAt(end$2);
      _tmp$2 = 56320 <= _p && _p <= 57343;
    } else {
      _tmp$2 = false;
    }
    if (_tmp$2) {
      return new Result$Err$0$(Error$moonbitlang$47$core$47$builtin$46$CreatingViewError$46$InvalidIndex);
    }
    return new Result$Ok$0$({ str: self, start: start$2, end: end$2 });
  } else {
    return new Result$Err$0$(Error$moonbitlang$47$core$47$builtin$46$CreatingViewError$46$IndexOutOfBounds);
  }
}
function moonbitlang$core$builtin$$Logger$write_substring$1$(self, value, start, len) {
  let _tmp;
  let _try_err;
  _L: {
    _L$2: {
      const _bind = moonbitlang$core$string$$String$sub$46$inner(value, start, start + len | 0);
      if (_bind.$tag === 1) {
        const _ok = _bind;
        _tmp = _ok._0;
      } else {
        const _err = _bind;
        const _tmp$2 = _err._0;
        _try_err = _tmp$2;
        break _L$2;
      }
      break _L;
    }
    _tmp = $panic();
  }
  moonbitlang$core$builtin$$Logger$write_view$0$(self, _tmp);
}
function moonbitlang$core$builtin$$Show$to_string$3$(self) {
  const logger = moonbitlang$core$builtin$$StringBuilder$new$46$inner(0);
  moonbitlang$core$builtin$$Show$output$4$(self, { self: logger, method_table: $$$64$moonbitlang$47$core$47$builtin$46$StringBuilder$36$as$36$64$moonbitlang$47$core$47$builtin$46$Logger });
  return logger.val;
}
function moonbitlang$core$builtin$$Show$to_string$5$(self) {
  const logger = moonbitlang$core$builtin$$StringBuilder$new$46$inner(0);
  moonbitlang$core$builtin$$Show$output$2$(self, { self: logger, method_table: $$$64$moonbitlang$47$core$47$builtin$46$StringBuilder$36$as$36$64$moonbitlang$47$core$47$builtin$46$Logger });
  return logger.val;
}
function moonbitlang$core$builtin$$Logger$write_iter$46$inner$2$(self, iter, prefix, suffix, sep, trailing) {
  self.method_table.method_0(self.self, prefix);
  if (trailing) {
    iter((x) => {
      moonbitlang$core$builtin$$Logger$write_object$2$(self, x);
      self.method_table.method_0(self.self, sep);
      return 1;
    });
  } else {
    const first = { val: true };
    iter((x) => {
      if (first.val) {
        first.val = false;
      } else {
        self.method_table.method_0(self.self, sep);
      }
      moonbitlang$core$builtin$$Logger$write_object$2$(self, x);
      return 1;
    });
  }
  self.method_table.method_0(self.self, suffix);
}
function moonbitlang$core$int$$Int$to_string$46$inner(self, radix) {
  return moonbitlang$core$builtin$$int_to_string_js(self, radix);
}
function moonbitlang$core$builtin$$Show$to_string$6$(self) {
  return self.str.substring(self.start, self.end);
}
function moonbitlang$core$builtin$$Iterator$next$2$(self) {
  const _func = self;
  return _func();
}
function moonbitlang$core$builtin$$Iterator$iter$2$(self) {
  return (yield_) => {
    while (true) {
      const _bind = moonbitlang$core$builtin$$Iterator$next$2$(self);
      if (_bind === undefined) {
        return 1;
      } else {
        const _Some = _bind;
        const _x = _Some;
        const _bind$2 = yield_(_x);
        if (_bind$2 === 1) {
        } else {
          return 0;
        }
        continue;
      }
    }
  };
}
function moonbitlang$core$builtin$$Logger$write_view$0$(self, str) {
  const _bind = self;
  _bind.val = `${_bind.val}${moonbitlang$core$builtin$$Show$to_string$6$(str)}`;
}
function moonbitlang$core$array$$Array$push$2$(self, value) {
  moonbitlang$core$builtin$$JSArray$push(self, value);
}
function moonbitlang$core$builtin$$Show$output$2$(self, logger) {
  logger.method_table.method_0(logger.self, moonbitlang$core$int$$Int$to_string$46$inner(self, 10));
}
function moonbitlang$core$array$$ArrayView$iterator$2$(self) {
  const i = { val: 0 };
  const _p = () => {
    if (i.val < (self.end - self.start | 0)) {
      const elem = self.buf[self.start + i.val | 0];
      i.val = i.val + 1 | 0;
      return elem;
    } else {
      return undefined;
    }
  };
  return _p;
}
function moonbitlang$core$array$$Array$iterator$2$(self) {
  return moonbitlang$core$array$$ArrayView$iterator$2$({ buf: self, start: 0, end: self.length });
}
function moonbitlang$core$array$$Array$iter$2$(self) {
  return moonbitlang$core$builtin$$Iterator$iter$2$(moonbitlang$core$array$$Array$iterator$2$(self));
}
function moonbitlang$core$builtin$$Show$output$4$(self, logger) {
  moonbitlang$core$builtin$$Logger$write_iter$46$inner$2$(logger, moonbitlang$core$array$$Array$iter$2$(self), "[", "]", ", ", false);
}
function moonbitlang$core$builtin$$println$7$(input) {
  console.log(input);
}
(() => {
  const arr = [1, 2, 3, 4, 5];
  moonbitlang$core$builtin$$println$7$(`Original array: ${moonbitlang$core$builtin$$Show$to_string$3$(arr)}`);
  let sum = 0;
  const _len = arr.length;
  let _tmp = 0;
  while (true) {
    const _i = _tmp;
    if (_i < _len) {
      const x = arr[_i];
      sum = sum + x | 0;
      _tmp = _i + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  moonbitlang$core$builtin$$println$7$(`Sum of array elements: ${moonbitlang$core$builtin$$Show$to_string$5$(sum)}`);
  const doubled = [];
  const _len$2 = arr.length;
  let _tmp$2 = 0;
  while (true) {
    const _i = _tmp$2;
    if (_i < _len$2) {
      const x = arr[_i];
      moonbitlang$core$array$$Array$push$2$(doubled, Math.imul(x, 2) | 0);
      _tmp$2 = _i + 1 | 0;
      continue;
    } else {
      break;
    }
  }
  moonbitlang$core$builtin$$println$7$(`Doubled array: ${moonbitlang$core$builtin$$Show$to_string$3$(doubled)}`);
})();
