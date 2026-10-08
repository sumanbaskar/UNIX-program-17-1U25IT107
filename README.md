Linux Password Expiry Management
Objective

Write a Bash script that demonstrates how to manage password-aging settings for a Linux user using the chage command.

Learning Outcomes

After completing this assignment, you should be able to:

Display password-aging information using chage.

Set the last password-change date.

Set the account expiration date.

Set the minimum number of days between password changes.

Set the maximum number of days a password remains valid.

Verify password-aging settings.

Task

Complete the file:

starter/password_expiry.sh


Your script must accept a username as its first command-line argument:

./password_expiry.sh <username>


The script must configure the specified user with these values:

Last password change: 2025-01-01

Account expiration date: 2026-12-31

Minimum password age: 7 days

Maximum password age: 90 days

The script should use the chage command.

Expected Usage
sudo ./password_expiry.sh student


After execution, the password-aging information can be inspected using:

sudo chage -l student

Requirements

Use Bash.

Use chage.

Accept the username from $1.

Validate that a username was supplied.

Configure all four required password-aging settings.

Return a non-zero exit status when the username is missing.

Do not hard-code the username.

Do not modify /etc/passwd or /etc/shadow directly.

Important

The automated tests create a temporary test user inside the GitHub Actions runner. Your script should therefore work with a normal Linux username supplied as $1.

Do not assume that the username is student.

Submission

Commit and push your completed starter/password_expiry.sh file to GitHub.

The GitHub Actions workflow will automatically run the tests.

Grading
Requirement	Marks
Accepts username argument	1
Validates missing username	1
Uses chage	2
Sets last password-change date	2
Sets account expiration date	1
Sets minimum password age	1
Sets maximum password age	1
Script executes successfully	1
Total	10
Example

A correct script should conceptually perform:

chage -d 2025-01-01 "$1"
chage -E 2026-12-31 "$1"
chage -m 7 "$1"
chage -M 90 "$1"


Students may implement the commands differently as long as the required final configuration is produced.
