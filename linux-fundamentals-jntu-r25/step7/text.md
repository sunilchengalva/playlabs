# Step 7 — Process Management & Cron

## What is a process?

Every running program is a **process** with a unique **PID** (Process ID). Linux is multi-process — many programs run simultaneously.

## Viewing processes

```bash
# Your current shell's processes
ps

# All processes on the system (snapshot)
ps aux

# Tree view showing parent-child relationships
ps auxf

# Interactive real-time viewer — press q to quit
top
```

Key `top` columns: **PID**, **USER**, **%CPU**, **%MEM**, **COMMAND**

## Background jobs

```bash
# Run a command in the background with &
sleep 300 &
sleep 400 &

# List background jobs in this shell
jobs

# Bring job 1 to the foreground
fg %1

# Suspend the foreground job (Ctrl+Z), then push it to background
bg %1

# Check the PID of the most recently backgrounded job
echo $!
```

## `kill` — send signals to processes

```bash
# Start a background process
sleep 1000 &

# List jobs with PIDs
jobs -l

# Send SIGTERM (graceful shutdown — default)
kill <PID>

# Force kill SIGKILL (cannot be ignored)
kill -9 <PID>

# Kill all processes named sleep
killall sleep
```

## `nohup` — keep running after logout

```bash
# Start a process that survives terminal close
nohup sleep 500 &
# Output is logged to nohup.out
```

## `nice` — start with a priority hint

```bash
# Lower priority (nice 10 = less urgent)
nice -n 10 sleep 200 &

# Check the NI column in top
ps aux | grep sleep
```

## Cron — scheduled tasks

Cron runs commands automatically on a time schedule.

```
* * * * *  command_to_run
│ │ │ │ └── day of week  (0–7, Sunday = 0 or 7)
│ │ │ └──── month        (1–12)
│ │ └────── day of month (1–31)
│ └──────── hour         (0–23)
└────────── minute       (0–59)
```

Common examples:

| Expression | Meaning |
|------------|---------|
| `* * * * *` | Every minute |
| `0 * * * *` | Every hour (at :00) |
| `0 9 * * 1` | Every Monday at 09:00 |
| `30 23 * * *` | Every day at 23:30 |
| `0 0 1 * *` | First day of every month at midnight |

```bash
# Edit the crontab (opens in nano or vi)
crontab -e

# Add this line to log the hostname every minute:
# * * * * * hostname >> /tmp/hostname.log

# List your current crontab entries
crontab -l

# Remove all crontab entries
crontab -r
```

---

## Task ✅

```bash
# 1. Start two background sleep processes
sleep 500 &
sleep 600 &

# 2. Record the PID of the last one
echo $! > ~/lab/jntu/bg_pid.txt

# 3. Kill all sleep processes
killall sleep

# 4. Add a cron job: append hostname to /tmp/hostname.log every minute
(crontab -l 2>/dev/null; echo "* * * * * hostname >> /tmp/hostname.log") | crontab -

# Verify the crontab was set
crontab -l
```
