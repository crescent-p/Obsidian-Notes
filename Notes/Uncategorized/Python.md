SortedList: log(n) insert delete update index
arr.bisect_left(val) : return the leftmost index where val should be inserted to keep arr sorted. (lower_bound) . Use in sorted Arr only
arr.bisect_right(val) : sam as bisect_left but returns rightmost index where it should be kept
list.count(val) : returns count of elements in that list
for value in map.values():
	"""returns the values only and not the keys"""
cppDict = defaultdict(value_type)

| To Access         | Method      | Example                                                 |
| ----------------- | ----------- | ------------------------------------------------------- |
| Keys              | `.keys()`   | `for k in d.keys():`                                    |
| Values            | `.values()` | `for v in d.values():`                                  |
| Both (key, value) | `.items()`  | `for k, v in d.items():`                                |
| Value by key      | `d[key]`    | `v = d['a']`                                            |
| Value safely      | `.get(key)` | `v = d.get('a', default_value_in_case_key_not_present)` |
q = deque()
q.append(), q.popleft(), q.pop(), q.appendleft(),
q.rotate(n) //shifts everything to left or right based on neg or pos
d = deque(maxlen=3) //pops from left end after reaching maxsize
:: used for slicing [start (inclusive):stop(exclusive):step] 
	eg:: appless[::3] == als
			appless[1:3:2] == pl
	