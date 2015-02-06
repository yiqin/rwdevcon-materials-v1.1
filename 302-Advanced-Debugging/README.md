# Seuss

Dr. Seuss book fan app with some subtle but deliberate bugs, as a demonstration of certain debugging techniques.

Most of the bugs are related to a special keyboard resigning overlay view which was added as a late requirement after the bulk of UAT had been completed. The requirement was to have the keyboard dismiss if the user taps anywhere else on the screen.

The tutorial is based on the stages of successful debugging (witty acronym required):

- Reproduction - unless you can reliably reproduce the bug, you'll never be sure that you've fixed it
- Location - where in the code is the bug happening? What specific line of code is doing the wrong thing?
- Root cause analysis - don't just assume that because you've found the line the bug is "on", thats where the problem originates. You need to examine the wider project and see how the app got to the buggy state in the first place. Is the real problem further upstream?
- Fix - what's the best way to fix the bug? Is it a simple typo or forgotten check, or is the app's state all wrong? Don't fix bugs by applying a set of checks and balances at the sharp end if the real problem is somewhere else.
- Confirmation - using the same reproduction steps, make sure the bug has gone, and make sure the original functionality is still working as well