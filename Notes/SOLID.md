S- single use case
a  class should only have a single funtion. group similar actions together.
O - open/closed principle
software entities, classes modules, functions etc should be open for extension but closed for modification.
use abstract class to create contracts that need to implemented by the extended class.
L - Liskov substitution 
No matter where you learned to drive on should be able to drive any car.
extended classes should be backward comapatible.

entities should be testable individullay. separate from the rest of the code.

I - interface segregation
The abstract class has a bunch of contracts the extendee classes has to fulfill.
But not all extendee classes have a use for that function. 
Solution is to create more interface classes. 
multiple abstract classes can be implemented by a single class.

D - dipendency inversion.
socket and bulb.
You dont want to solder a bulb into the socket. Bulb can be changed. bulb here is 3rd party services, that can change over time.
![[Pasted image 20240722203051.png]]