# Step 8 — User & Group Management

Linux is a multi-user system. Every file, process, and permission is tied to a user and a group.

---

## Who am I right now?

```bash
whoami
```

```bash
id
```

```bash
who
```

```bash
w
```

```bash
last
```

---

## The user database

View the user database (format: `username:x:UID:GID:comment:home:shell`):

```bash
cat /etc/passwd
```

Filter to a specific user:

```bash
grep root /etc/passwd
```

View the group database:

```bash
cat /etc/group | head -20
```

---

## Create a user

Create `student1` with a home directory and bash shell:

```bash
useradd -m -s /bin/bash student1
```

Confirm the user entry was added:

```bash
grep student1 /etc/passwd
```

Confirm the home directory was created:

```bash
ls /home/student1
```

Set a password:

```bash
passwd student1
```

---

## Modify a user

Change the default shell:

```bash
usermod -s /bin/sh student1
```

Add to a supplementary group (`-a` = append, `-G` = groups):

```bash
usermod -aG sudo student1
```

Verify the change:

```bash
id student1
```

```bash
groups student1
```

---

## Create and manage groups

Create a new group:

```bash
groupadd labusers
```

Add `student1` to the group:

```bash
usermod -aG labusers student1
```

Confirm the group entry:

```bash
grep labusers /etc/group
```

Confirm the user's membership:

```bash
id student1
```

---

## Switch user: `su`

Switch to `student1`:

```bash
su - student1
```

Confirm you are now that user:

```bash
whoami
```

Return to root:

```bash
exit
```

---

## Delete a user

Remove the user but keep the home directory:

```bash
userdel student1
```

Remove the user AND the home directory:

```bash
userdel -r student1
```

Confirm the user is gone:

```bash
grep student1 /etc/passwd
```

---

## Task ✅

Create user `jntustudent` with a home directory and bash shell:

```bash
useradd -m -s /bin/bash jntustudent
```

Create group `jntulab`:

```bash
groupadd jntulab
```

Add `jntustudent` to `jntulab`:

```bash
usermod -aG jntulab jntustudent
```

Record the user's identity information:

```bash
id jntustudent > ~/lab/jntu/user_info.txt
```

```bash
cat ~/lab/jntu/user_info.txt
```
