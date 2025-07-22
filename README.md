# Dining Philosophers Problem Solution

A modified implementation of the classic Dining Philosophers Problem using C with POSIX threads and semaphores.

## Problem Description

The Dining Philosophers Problem is a classic synchronization problem in computer science that illustrates the challenges of allocating multiple resources among multiple processes in a deadlock-free and starvation-free manner.

## Features

- **Deadlock Prevention**: Uses ordered locking mechanism to prevent circular wait conditions
- **Starvation Free**: Ensures all philosophers get equal opportunity to eat
- **Memory Efficient**: Only allows N-1 philosophers to compete simultaneously
- **Thread Safe**: Implements proper synchronization using mutexes and semaphores
- **Configurable**: Easy to modify number of philosophers and meals per philosopher

## Implementation Details

### Key Components

- **Semaphore (`dining_room`)**: Controls maximum number of philosophers that can attempt to dine simultaneously
- **Mutex Array (`forks`)**: Protects each fork from concurrent access
- **Output Lock**: Ensures thread-safe console output
- **Random Timing**: Philosophers think and eat for random durations

### Synchronization Strategy

1. **Dining Room Access Control**: Maximum of N-1 philosophers can enter the dining room
2. **Ordered Fork Acquisition**: Philosophers pick up forks in numerical order to prevent deadlock
3. **Atomic Operations**: All critical sections are properly protected

## Compilation and Execution

### Prerequisites

- GCC compiler with pthread support
- POSIX-compliant system (Linux, macOS, Unix)

### Compile

```bash
gcc -o dining_philosophers dining_philosophers.c -lpthread
```

### Run

```bash
./dining_philosophers
```

## Configuration

You can modify these constants in the source code:

```c
#define TOTAL_PHILOSOPHERS 5    // Number of philosophers
#define THINK_TIME_MIN 1        // Minimum thinking time (seconds)
#define THINK_TIME_MAX 3        // Maximum thinking time (seconds)
#define EAT_TIME_MIN 1          // Minimum eating time (seconds)
#define EAT_TIME_MAX 2          // Maximum eating time (seconds)
```

## Sample Output

```
=== Dining Philosophers Simulation Started ===
Configuration: 5 philosophers, 3 meals each

[Philosopher 0] is pondering life's mysteries...
[Philosopher 1] is pondering life's mysteries...
[Philosopher 2] feels hungry and wants to dine
[Philosopher 2] picked up left fork
[Philosopher 2] picked up right fork
[Philosopher 2] is enjoying a delicious meal
...
```

## Algorithm Analysis

### Time Complexity
- **Per Philosopher**: O(m) where m is meals per philosopher
- **Overall**: O(n × m) where n is number of philosophers

### Space Complexity
- **Memory Usage**: O(n) for n philosophers
- **Synchronization Objects**: O(n) mutexes + 1 semaphore

### Properties
- ✅ **Mutual Exclusion**: Each fork can only be held by one philosopher
- ✅ **Deadlock Free**: Ordered locking prevents circular dependencies
- ✅ **Starvation Free**: Semaphore ensures fair access to dining room
- ✅ **Bounded Waiting**: No philosopher waits indefinitely

## Project Structure

```
.
├── dining_philosophers.c    # Main implementation
├── README.md               # This file
└── Makefile               # Build configuration (optional)
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/improvement`)
3. Commit your changes (`git commit -am 'Add some improvement'`)
4. Push to the branch (`git push origin feature/improvement`)
5. Create a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## References

1. Dijkstra, E. W. (1965). Solution of a Problem in Concurrent Programming Control. Communications of the ACM, 8(9), 569.
2. Silberschatz, A., Galvin, P. B., & Gagne, G. (2018). Operating System Concepts (10th ed.). Wiley.
3. Tanenbaum, A. S., & Bos, H. (2015). Modern Operating Systems (4th ed.). Pearson.

## Author

Rafael Valentino Patrick Tantokusumo  
NPM: 243401001  
Mata Kuliah: IF-OS

---

**Note**: This implementation is based on academic research and is intended for educational purposes in operating systems and concurrent programming courses.
