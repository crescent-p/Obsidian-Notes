Tags : [[shell]], [[scripting]]

Finds consecutive repetitions and combines them into single value.
1. `$ cat pets.txt`
2. `goldfish`
3. `dog`
4. `cat`
5. `parrot`
6. `dog`
7. `goldfish`
8. `goldfish`

#### After using uniq
1. `$ uniq pets.txt`
2. `goldfish`
3. `dog`
4. `cat`
5. `parrot`
6. `dog`
7. `goldfish`

