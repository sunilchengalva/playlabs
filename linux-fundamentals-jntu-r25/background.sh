#!/bin/bash
# Pre-stages the lab environment for all 9 steps.

# ── Directory skeleton ──────────────────────────────────────────────────────
mkdir -p /root/lab/data
mkdir -p /root/lab/projects/webapp
mkdir -p /root/lab/projects/api
mkdir -p /root/lab/scripts
mkdir -p /root/lab/backup
mkdir -p /root/lab/jntu   # base dir; students create subdirs in step 2

# ── Sample log file (15 lines) ──────────────────────────────────────────────
cat > /root/lab/data/server.log << 'EOF'
2026-01-15 08:00:01 INFO  Server started on port 8080
2026-01-15 08:01:23 INFO  User admin logged in from 192.168.1.10
2026-01-15 08:05:44 ERROR Failed to connect to database: timeout
2026-01-15 08:06:01 INFO  Retrying database connection
2026-01-15 08:06:03 INFO  Database connection established
2026-01-15 08:15:30 WARNING Disk usage at 75%
2026-01-15 09:00:00 INFO  Scheduled backup started
2026-01-15 09:02:11 INFO  Backup completed: 234 MB
2026-01-15 10:30:45 ERROR Null pointer exception in UserService.java:142
2026-01-15 10:31:00 INFO  Service restarted automatically
2026-01-15 11:00:00 WARNING Disk usage at 80%
2026-01-15 12:00:00 INFO  Scheduled backup started
2026-01-15 12:02:30 INFO  Backup completed: 236 MB
2026-01-15 14:45:22 ERROR Authentication failed for user: guest
2026-01-15 14:46:00 INFO  IP 10.0.0.55 blocked after 3 failed attempts
EOF

# ── Student CSV (1 header + 10 rows = 11 lines) ─────────────────────────────
cat > /root/lab/data/students.csv << 'EOF'
RollNo,Name,Branch,Marks,Grade
22CS001,Arjun Sharma,CSE,88,A
22CS002,Priya Reddy,CSE,74,B
22CS003,Rahul Verma,CSE,91,A+
22CS004,Sneha Patel,CSE,55,C
22CS005,Kiran Kumar,CSE,67,B
22IT001,Meera Nair,IT,82,A
22IT002,Suresh Babu,IT,49,D
22IT003,Ananya Singh,IT,95,A+
22IT004,Vikram Rao,IT,61,B
22IT005,Deepika Joshi,IT,78,B+
EOF

# ── Web project files ───────────────────────────────────────────────────────
cat > /root/lab/projects/webapp/index.html << 'EOF'
<!DOCTYPE html>
<html>
<head><title>JNTU Linux Lab</title></head>
<body><h1>Hello from the Linux Lab!</h1></body>
</html>
EOF

cat > /root/lab/projects/api/config.txt << 'EOF'
host=localhost
port=3000
db_host=127.0.0.1
db_port=5432
db_name=appdb
debug=true
max_connections=100
EOF

# ── Permissions exercise files ──────────────────────────────────────────────
# Intentionally over-permissive — students fix it in step 4
touch /root/lab/secret.conf
chmod 777 /root/lab/secret.conf

# Script exists but is not executable — students chmod +x it in step 4
cat > /root/lab/scripts/hello.sh << 'EOF'
#!/bin/bash
echo "Hello from JNTU Linux Lab!"
echo "Current user : $(whoami)"
echo "Current dir  : $(pwd)"
EOF
chmod 644 /root/lab/scripts/hello.sh

echo "ready" > /tmp/lab_ready
