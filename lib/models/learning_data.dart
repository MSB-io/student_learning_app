import 'package:flutter/material.dart';

class Question {
  final String questionText;
  final List<String> options;
  final int correctOptionIndex;
  final String explanation;

  const Question({
    required this.questionText,
    required this.options,
    required this.correctOptionIndex,
    required this.explanation,
  });
}

class Chapter {
  final String id;
  final int chapterNumber;
  final String title;
  final String duration;
  final String summary;
  final List<String> keyPoints;
  final List<Question> quiz;

  const Chapter({
    required this.id,
    required this.chapterNumber,
    required this.title,
    required this.duration,
    required this.summary,
    required this.keyPoints,
    required this.quiz,
  });
}

class Subject {
  final String id;
  final String title;
  final String code;
  final IconData icon;
  final Color color;
  final List<Chapter> chapters;

  const Subject({
    required this.id,
    required this.title,
    required this.code,
    required this.icon,
    required this.color,
    required this.chapters,
  });
}

// Hardcoded dummy data for subjects and chapters
final List<Subject> sampleSubjects = [
  Subject(
    id: 'ccn',
    title: 'Computer Networks',
    code: 'CS-501',
    icon: Icons.hub_outlined,
    color: const Color(0xFF2563EB), // Blue
    chapters: [
      Chapter(
        id: 'cn_ch1',
        chapterNumber: 1,
        title: 'Network Models & OSI Reference',
        duration: '25 mins',
        summary:
            'The Open Systems Interconnection (OSI) model characterizes and standardizes the communication functions of a telecommunication or computing system without regard to its underlying internal structure.',
        keyPoints: [
          'The OSI model has 7 layers: Physical, Data Link, Network, Transport, Session, Presentation, and Application.',
          'Physical Layer: Handles bit-level transmission across physical media.',
          'Data Link Layer: Handles node-to-node frame delivery and MAC addressing.',
          'Network Layer: Responsible for packet routing and logical IP addressing.',
          'Transport Layer: Provides host-to-host communication and flow/error control (TCP/UDP).',
        ],
        quiz: [
          Question(
            questionText: 'Which OSI layer is responsible for logical routing of packets?',
            options: ['Data Link Layer', 'Network Layer', 'Transport Layer', 'Physical Layer'],
            correctOptionIndex: 1,
            explanation: 'The Network Layer (Layer 3) handles IP addressing and packet routing between networks.',
          ),
          Question(
            questionText: 'Which protocol is connection-oriented and ensures reliable data delivery?',
            options: ['UDP', 'IP', 'TCP', 'ICMP'],
            correctOptionIndex: 2,
            explanation: 'TCP (Transmission Control Protocol) provides connection-oriented, reliable delivery via 3-way handshake.',
          ),
          Question(
            questionText: 'What is the Protocol Data Unit (PDU) at Layer 2 (Data Link)?',
            options: ['Bit', 'Frame', 'Packet', 'Segment'],
            correctOptionIndex: 1,
            explanation: 'At the Data Link layer, data is packaged into Frames with MAC headers and trailers.',
          ),
        ],
      ),
      Chapter(
        id: 'cn_ch2',
        chapterNumber: 2,
        title: 'IP Addressing & Subnetting',
        duration: '30 mins',
        summary:
            'Internet Protocol (IP) addressing assigns logical identifiers to devices. IPv4 uses 32-bit addresses divided into Network and Host portions using subnet masks.',
        keyPoints: [
          'IPv4 addresses are 32 bits (4 octets) written in dotted-decimal notation.',
          'IPv6 addresses are 128 bits represented in hexadecimal separated by colons.',
          'Classes: Class A (large networks), Class B (medium), Class C (small), Class D (multicast), Class E (experimental).',
          'Subnetting divides a larger network into smaller, manageable subnets to conserve addresses and improve security.',
        ],
        quiz: [
          Question(
            questionText: 'How many bits are used in an IPv4 address?',
            options: ['16 bits', '32 bits', '64 bits', '128 bits'],
            correctOptionIndex: 1,
            explanation: 'IPv4 addresses consist of 32 bits arranged in 4 bytes (octets).',
          ),
          Question(
            questionText: 'Which IP address class is specifically reserved for multicasting?',
            options: ['Class A', 'Class B', 'Class C', 'Class D'],
            correctOptionIndex: 3,
            explanation: 'Class D (224.0.0.0 to 239.255.255.255) is designated for multicast groups.',
          ),
          Question(
            questionText: 'What is the default subnet mask for a Class C network?',
            options: ['255.0.0.0', '255.255.0.0', '255.255.255.0', '255.255.255.255'],
            correctOptionIndex: 2,
            explanation: 'Class C uses 24 bits for the network ID, giving a default mask of 255.255.255.0 (/24).',
          ),
        ],
      ),
      Chapter(
        id: 'cn_ch3',
        chapterNumber: 3,
        title: 'Routing Protocols & Algorithms',
        duration: '35 mins',
        summary:
            'Routing protocols determine the optimal path for packets across interconnected networks. Protocols are classified into Distance Vector, Link State, and Path Vector.',
        keyPoints: [
          'Routers operate at Layer 3 to forward packets across different subnets.',
          'Routing Information Protocol (RIP): Distance-vector protocol using hop count as metric (maximum 15 hops).',
          'Open Shortest Path First (OSPF): Link-state protocol using Dijkstra algorithm for shortest path calculation.',
          'Border Gateway Protocol (BGP): The standard exterior gateway protocol used across autonomous systems on the Internet.',
        ],
        quiz: [
          Question(
            questionText: 'What is the maximum allowed hop count in the RIP routing protocol?',
            options: ['15', '16', '30', 'Unlimited'],
            correctOptionIndex: 0,
            explanation: 'RIP permits a maximum of 15 hops; a hop count of 16 signifies an unreachable destination.',
          ),
          Question(
            questionText: 'Which shortest-path algorithm is utilized by OSPF?',
            options: ['Bellman-Ford', 'Dijkstra Algorithm', 'Floyd-Warshall', 'Kruskal Algorithm'],
            correctOptionIndex: 1,
            explanation: 'OSPF uses Dijkstra Shortest Path First (SPF) algorithm to calculate loop-free shortest paths.',
          ),
        ],
      ),
      Chapter(
        id: 'cn_ch4',
        chapterNumber: 4,
        title: 'Network Security & Firewalls',
        duration: '20 mins',
        summary:
            'Network security involves policies and practices to prevent unauthorized access, misuse, modification, or denial of computer networks and network-accessible resources.',
        keyPoints: [
          'Firewalls monitor and filter incoming and outgoing network traffic based on predetermined security rules.',
          'Symmetric Encryption: Same secret key is used for both encryption and decryption (e.g. AES).',
          'Asymmetric Encryption: Uses a public key for encryption and a private key for decryption (e.g. RSA).',
          'HTTPS secures web communication using Transport Layer Security (TLS) over port 443.',
        ],
        quiz: [
          Question(
            questionText: 'Which standard TCP port is utilized for secure web browsing (HTTPS)?',
            options: ['80', '22', '443', '8080'],
            correctOptionIndex: 2,
            explanation: 'HTTPS operates over TCP port 443, utilizing TLS/SSL for encrypted communications.',
          ),
          Question(
            questionText: 'Which encryption technique uses public and private key pairs?',
            options: ['Symmetric Encryption', 'Asymmetric Encryption', 'Hash Function', 'Caesar Cipher'],
            correctOptionIndex: 1,
            explanation: 'Asymmetric (public-key) cryptography uses a public key to encrypt and a private key to decrypt.',
          ),
        ],
      ),
    ],
  ),
  Subject(
    id: 'os',
    title: 'Operating Systems',
    code: 'CS-502',
    icon: Icons.memory_outlined,
    color: const Color(0xFF0D9488), // Teal
    chapters: [
      Chapter(
        id: 'os_ch1',
        chapterNumber: 1,
        title: 'Process Management & CPU Scheduling',
        duration: '25 mins',
        summary: 'Process states, PCB, context switching, and scheduling algorithms like FCFS, SJF, and Round Robin.',
        keyPoints: [
          'A process is a program in execution containing program counter, stack, and data section.',
          'CPU scheduling algorithms balance throughput, turnaround time, and response time.',
        ],
        quiz: [
          Question(
            questionText: 'Which scheduling algorithm is non-preemptive by default?',
            options: ['Round Robin', 'First Come First Served (FCFS)', 'SRTF', 'Priority Preemptive'],
            correctOptionIndex: 1,
            explanation: 'FCFS executes processes in the exact order of arrival without preemption.',
          ),
        ],
      ),
    ],
  ),
  Subject(
    id: 'dsa',
    title: 'Data Structures',
    code: 'CS-503',
    icon: Icons.account_tree_outlined,
    color: const Color(0xFF7C3AED), // Purple
    chapters: [
      Chapter(
        id: 'dsa_ch1',
        chapterNumber: 1,
        title: 'Arrays, Stacks & Queues',
        duration: '30 mins',
        summary: 'Linear data structures: contiguous array storage, LIFO stack semantics, and FIFO queue semantics.',
        keyPoints: [
          'Stack follows Last In First Out (LIFO) order.',
          'Queue follows First In First Out (FIFO) order.',
        ],
        quiz: [
          Question(
            questionText: 'Which principle is followed by a Stack data structure?',
            options: ['FIFO', 'LIFO', 'Priority', 'Random Access'],
            correctOptionIndex: 1,
            explanation: 'Stack works on Last-In, First-Out (LIFO) principle.',
          ),
        ],
      ),
    ],
  ),
  Subject(
    id: 'dbms',
    title: 'Database Management',
    code: 'CS-504',
    icon: Icons.storage_outlined,
    color: const Color(0xFFEA580C), // Orange
    chapters: [
      Chapter(
        id: 'dbms_ch1',
        chapterNumber: 1,
        title: 'Relational Model & Normalization',
        duration: '25 mins',
        summary: 'Relational schema, keys (Primary, Foreign), and normal forms 1NF, 2NF, and 3NF.',
        keyPoints: [
          'Normalization eliminates data redundancy and prevents update anomalies.',
          'ACID properties ensure reliable database transaction processing.',
        ],
        quiz: [
          Question(
            questionText: 'What does the "A" in ACID database properties stand for?',
            options: ['Availability', 'Atomicity', 'Accuracy', 'Authentication'],
            correctOptionIndex: 1,
            explanation: 'Atomicity ensures that all operations in a transaction either complete entirely or fail completely.',
          ),
        ],
      ),
    ],
  ),
];
