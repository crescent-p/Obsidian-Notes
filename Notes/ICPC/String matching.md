
## KMP ( Knuth-Morris-Pratt Algorithm )
	Precompute a prefix == suffix array for the pattern and use it to solve the prohlem


## Z-Algorithm
	Generate the z arraya using dp.

```cpp
vector<ll> createZ(string text) {  
    vector<ll> arr(text.length());  
    int n = text.length();  
    int left = 0;  /'init box to [0, 0]
    int right = 0;  
    for(int i = 1; i < n; i++) {  
        if(i > right) {  
            right = left = i;  
            / 'Expand box if prefix == sufix is found'
            while(right < n && text[right] == text[right - left]) {  
                right++;  
            }  
            arr[i] = right - left;  
            right--;  
        }else {  
            int i1 = i - left;  
	        / 'if computed value doesnt exceed Z box just copy value'
            if(arr[i1] < right - i + 1) {  
                arr[i] = arr[i1];  
            }else {  
            / 'if Z box exceeded expand box by starting the next comparison from right.
                left = i;  
                while(right < n && text[right] == text[right - left]) {  
                    right++;  
                }  
                arr[i] = right - left;  
                right--;  
            }  
        }  
    }  
    return arr;  
}

```
