# Step 8 — User & Group Management

Linux is a multi-user system. Every file, process, and permission is tied to a user and a group.

## Who am I right now?

```bash
whoami          # username of the current user
id              # UID, primary GID, and all supplementary groups
who             # users currently logged in
w               # logged-in users with what they are running
last            # login history from /var/log/wtmp
```

## The user database

```bash
# Each line: username:x:UID:GID:comment:home:shell
cat /etc/passwd
grep root /etc/passwd

# Group database: groupname:x:GID:members
cat /etc/group | head -20
```

## Create a user

```bash
# -m creates the home directory
# -s sets the login shell
useradd -m -s /bin/bash student1

# Confirm creation
grep student1 /etc/passwd
ls /home/student1

# Set a password
passwd student1
```

## Modify a user

```bash
# Change the default shell
usermod -s /bin/sh student1

# Add to a supplementary group (-a = append, -G = groups)
usermod -aG sudo student1

# Verify
id student1
groups student1
```

## Create and manage groups

```bash
# Create a new group
groupadd labusers

# Add a user to the group
usermod -aG labusers student1

# Confirm
grep labusers /etc/group
id student1
```

## Switch user: `su`

```bash
# Switch to student1 (prompts for password)
su - student1
whoami
exit            # return to root
```

## Delete a user

```bash
# Remove user, keep home directory
userdel student1

# Remove user AND home directory
userdel -r student1

# Confirm removal
grep student1 /etc/passwd
```

---

## Task ✅

```bash
# Create user jntustudent with home directory and bash shell
useradd -m -s /bin/bash jntustudent

# Create group jntulab
groupadd jntulab

# Add jntustudent to jntulab
usermod -aG jntulab jntustudent

# Record the user's identity information
id jntustudent > ~/lab/jntu/user_info.txt
cat ~/lab/jntu/user_info.txt
```
