
# Basic Ciphers
## Caesar Cipher
	E(n) = (m + k) mod 26
	D(n) = (E(n) - k) mod 26

## Security Goals
	1) Confidentiality - only authorized people can access
	2) Integrity - unauthorized people cant access
	3) Availability - must be available to authorized people
	4) Entity authentication - corroborating the identity of other person. B should be conviced the other parties identity.
	5) Non repudation - preventing an authority from denying previous communications.

## Symmetric key cryptography
	A single key
	1) RC4
	2) DES (data encryption standard)
	3) AES (advanced encryption standard)

	The key is transfered through a secure channel and the message can be sent through any public channel.

## Asymmetric key cryptography
	public key/ private key cryptography
	1) RSA
	2) El-gamal
	3) Eliptic curve cryptography


### RSA (Rivet Shamir Adelman)
	1) choose two primes p,q with bitlenght l/2
	2) make n = pq and compute phi(n) = (p - 1) * (q - 1)
	3) choose e such that gcd(phi, e) = 1
	4) compute g such that eg mod (phi) = 1
	5) Encrypt message as ENCRYPT = M ^ (e) mod n
	6) Decrypt the cipher text as DECRYPT = C ^ g mod n = M ^ (ge) mod n = M mod n
	7) a ^ phi(n) mod n = 1

## Discrete log problem
	1) choose p a large prime
	2) choose q such that p - 1 is divisilble by q
	3) choose g a generator from [1 , p - 1]
		1) g has order q meaning g ^ q mod (p) = 1 and no smaller t satisfies g ^ t mod (p) = 1
	4) Now we have (g, p, q)
	5) Choose x such that y = g ^ x mod (p)
		1) y depends on (g, x, p) but x remains secret.
		2) this is the discrete log problem.
##### Why g Must Have Order q

	- Ensures g ^ t mod  p = 1 only when t is a multiple of q. This property creates a cyclic subgroup of order q within Zp∗​.
	- Without this property, the structure becomes less predictable and less secure.

## El Gamal Cryptography
	Choose prime p and generator g.
	choose x randomly x E [1, p - 2]
	compute y = g ^ x mod (p)

### Signature
	private key (x)
	public key(p, q, g, y)
		y = g ^ x mod (p)
			g is generate such that g ^ q mod (p) = 1 that g has order q
	# Signing the message
		Use a good hash fucntion to genrate a hash value. This is to reduce the number of bits we want to work with.
	Compute 
	Choose an ephemeral key [1 , q - 1] where gcd(k, q) = 1
		r = g ^ k mod p
		s = k^-1 (H(m) + x r) mod q
			if s = 0 choose different key k
		signature is the pair (r, s)

	# verifying the signature
	ensure r E [1, p - 1] and s E [1, q - 1] else reject the signature
	v1 = g ^ H(m) mod p
	v2 = (y ^ r) * (r ^ s) mod p 
	check if v1 = v2 otherwise invalid.


# Elliptic Curve Cryptography
	domain parameters (p, E, P, n)
	P is the starting point on the ellptic curve.
	Public key = (Q the elliptic curve after dP) 
	Private key d. Q = dP 

## El-Gamal with ECC
	Choose domain parameters (p (prime number defining the field), E)

	The elliptic curve
	
$$y^2=x^3+ax+b\mod p$$

	To Ensure the curve has no singularites

	$$4a^3+27b^2=0\mod p$$ Domain parameters
	A finite field size p
	curve coeffecients a and b
	A base point G (a generator point on the curve)
	The order n of G, where nG = O (point at infinity)
	h = #of point in Q (the curve)
	
	Private key d (a random integer in [1, n - 1])
	Public key Q : computed as Q = dG
	**Elliptic Curve Discrete Logarithm Problem (ECDLP)** 
		Given Q and G it is infeasible to calculate d.

	Encryption : 
		Compute A = dG
		Compute B = fG

	Transmit both
		Compute K = fA = fdG
		Compute K = dB = dfG

	Succefully transmitted key without sharing each others private key.\


## ECC encryption and decryption
	1) Represent the message m as a point M in E(Field modulo P)
	2) Select 
	3) C1 = kP
	4) Q = dG
	5) C2 = M + kQ
	6) M = C2 - C1*d
		1) M = M + kQ - kdG
		2) M = M + k * (dG) - kdG
## Key generation with ECC
	1) choose k a random integer in n [The order of ECC G, ie nG = O]
	2) privage key d
	3) public key y = dP
	4) R = kP
	5) r = X coordinate of R modulo n

6) ![[Pasted image 20241124113610.png]]

	Checking the signature.
		$$w = s^-1 \mod n$$
		$$u = H(m)*w \mod n$$
		$$v = rw \mod n$$
		$$R = uP + vQ$$
		Accept the signature if x coordinate of R is $$r \mod n$$
![[Pasted image 20241124131903.png]]


![[Pasted image 20241124162414.png]]
