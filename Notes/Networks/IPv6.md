IPv6 is the latest version of the Internet Protocol designed to replace IPv4, offering a vastly larger address space and improved functionality. Below is an explanation of IPv6 and its notation:

### **IPv6 Overview**
- **Address Size**: IPv6 uses 128-bit addresses, allowing approximately $$3.4 \times 10^{38}$$ unique addresses, compared to IPv4's 32-bit addressing system[2][3].
- **Structure**: An IPv6 address consists of eight groups of 16-bit segments (nibbles), represented as four hexadecimal digits in each group and separated by colons (`:`)[1][3][6].

### **IPv6 Notation**
IPv6 addresses are written in hexadecimal format with specific rules to simplify their representation:

#### **Standard Format**
- The full IPv6 address is represented as `x:x:x:x:x:x:x:x`, where each `x` is a 16-bit hexadecimal value ranging from `0000` to `FFFF`[1][5].
- Example: `2001:0db8:85a3:0000:0000:8a2e:0370:7334`.

#### **Simplification Rules**
1. **Omitting Leading Zeros**:
   - Leading zeros in each segment can be removed.
   - Example: `2001:0db8:0000:0000:0000:0000:0000:0001` becomes `2001:db8:0:0:0:0:0:1`[1][4].

2. **Using Double Colons (`::`)**:
   - Consecutive blocks of zeroes can be replaced with a double colon (`::`), but this can only be used once in an address.
   - Example:
     - Full Address: `2001:0db8:0000:0000:0000:0000:0000:0001`.
     - Simplified Address: `2001:db8::1`[2][4].

#### **IPv4-Mapped IPv6 Addresses**
- To ensure compatibility with IPv4, IPv6 can embed an IPv4 address within its format.
- Example:
  - Full Address: `::ffff:192.168.1.1`.
  - This represents the IPv4 address `192.168.1.1` in an IPv6-compatible format[1].

#### **CIDR Notation**
- IPv6 uses CIDR (Classless Inter-Domain Routing) notation to specify subnets, similar to IPv4.
- Example:
  - Single Host Address: `2001:db8::1/128`.
  - Network Address Prefix: `2001:db8::/64`[2].
