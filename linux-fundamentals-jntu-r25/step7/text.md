# Step 7 — Process Management & Cron

## What is a process?

Every running program is a **process** with a unique **PID** (Process ID). Linux is multi-process — many programs run simultaneously.

---

## Viewing processes

Your current shell's processes:

```bash
ps
```

All processes on the system (snapshot):

```bash
ps aux
```

Tree view showing parent-child relationships:

```bash
ps auxf
```

Interactive real-time viewer — press `q` to quit:

```bash
top
```

Key `top` columns: **PID**, **USER**, **%CPU**, **%MEM**, **COMMAND**

---

## Background jobs

Run a command in the background with `&`:

```bash
sleep 300 &
```

```bash
sleep 400 &
```

List background jobs in this shell:

```bash
jobs
```

Bring job 1 to the foreground:

```bash
fg %1
```

Suspend the foreground job with **Ctrl+Z**, then push it to background:

```bash
bg %1
```

Print the PID of the most recently backgrounded job:

```bash
echo $!
```

---

## `kill` — send signals to processes

Start a background process to practice on:

```bash
sleep 1000 &
```

List jobs with their PIDs:

```bash
jobs -l
```

Send SIGTERM (graceful shutdown — default). Replace `<PID>` with the actual number from `jobs -l`:

```bash
kill <PID>
```

Force-kill with SIGKILL (cannot be ignored):

```bash
kill -9 <PID>
```

Kill all processes with a given name:

```bash
killall sleep
```

---

## `nohup` — keep running after logout

```bash
nohup sleep 500 &
```

Output is logged to `nohup.out` automatically.

---

## `nice` — start with a priority hint

Start a process with lower priority (nice value 10):

```bash
nice -n 10 sleep 200 &
```

Check the NI column to confirm:

```bash
ps aux | grep sleep
```

---

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

| Expression | Meaning |
|------------|---------|
| `* * * * *` | Every minute |
| `0 * * * *` | Every hour (at :00) |
| `0 9 * * 1` | Every Monday at 09:00 |
| `30 23 * * *` | Every day at 23:30 |
| `0 0 1 * *` | First day of every month at midnight |

Open the crontab editor (opens in nano or vi):

```bash
crontab -e
```

List current crontab entries:

```bash
crontab -l
```

Remove all crontab entries:

```bash
crontab -r
```

---

## Task ✅

Start two background processes:

```bash
sleep 500 &
```

```bash
sleep 600 &
```

Record the PID of the last background job (`$!` always holds it):

```bash
echo $! > ~/lab/jntu/bg_pid.txt
```

Kill all sleep processes:

```bash
killall sleep
```

Add a cron job that appends the hostname every minute (this is a pipeline and must stay as one command):

```bash
(crontab -l 2>/dev/null; echo "* * * * * hostname >> /tmp/hostname.log") | crontab -
```

Confirm the crontab was set:

```bash
crontab -l
```
