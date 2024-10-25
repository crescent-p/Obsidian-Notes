
Tags : [[shell]], [[scripting]], [[Pipes]]
### Usage
	 `tr [OPTIONS] [target characters] [replacement characters]`

##### Example
```
$ echo "Linux and shell scripting are awesome\!" | tr "aeiou" "_"`
`L_n_x _nd sh_ll scr_pt_ng _r_ _w_s_m_!`
````
`$ tr “[a-z]” “[A-Z]” < a_text_file.txt`