Priority inversion is a scenario in concurrent programming where a higher-priority task is waiting for a lower-priority task to release a resource, thereby "inverting" the expected priority-based execution order.

### How Priority Inversion Happens:
1. **High-Priority Task**: Task \( T_H \) requires a resource currently held by a lower-priority task \( T_L \).
2. **Medium-Priority Task**: Meanwhile, a medium-priority task \( T_M \) that does not depend on the shared resource can preempt \( T_L \) and run instead, further delaying \( T_L \) from releasing the resource.

### Example:
- **Tasks**: \( T_H \) (high priority), \( T_M \) (medium priority), \( T_L \) (low priority).
- **Shared Resource**: \( R \) needed by both \( T_H \) and \( T_L \).

1. \( T_L \) acquires \( R \).
2. \( T_H \) preempts \( T_L \) and tries to acquire \( R \), but it has to wait since \( T_L \) is holding it.
3. \( T_M \) preempts \( T_L \) since \( T_M \) has higher priority than \( T_L \) but lower than \( T_H \).
4. \( T_H \) has to wait until both \( T_L \) and \( T_M \) complete, effectively causing a priority inversion.

### Solutions to Priority Inversion:
1. **Priority Inheritance Protocol**: The low-priority task \( T_L \) temporarily "inherits" the higher priority of the task \( T_H \) waiting for the resource. This prevents medium-priority tasks from preempting \( T_L \) until it releases the resource.
2. **Priority Ceiling Protocol**: Each resource is assigned a priority ceiling, which is the highest priority of any task that may lock the resource. A task can only lock a resource if its priority is higher than the priority ceiling of all currently locked resources. This prevents lower-priority tasks from interfering with higher-priority ones.

Priority inversion can cause significant performance degradation and unpredictability in real-time systems, so understanding and mitigating it is crucial in systems requiring high reliability and predictability.