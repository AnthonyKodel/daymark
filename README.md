# Daymark

A single-file daily productivity dashboard: a focus timer that links to what you're
working on, tasks that carry over and age, weekly routines, and habit streaks.

**Everything stays in your own browser.** There is no server, no account, and no
sign-up. Each person who opens the page gets their own private copy of the data,
stored in their browser's `localStorage`. Nothing is ever sent anywhere.

## What's in it

**Focus timer** — 15 / 25 / 50-minute sessions with a progress ring, and a break of
1, 3, 5 minutes or none at all. Completed sessions log automatically.

- **Link a session to a task.** Pick a task from the dropdown before you start and
  those minutes are attributed to it. Each task then shows its lifetime focused
  minutes, and a "Focused on today" breakdown appears under the timer.
- **Interruption tracking.** Hit **Interrupted** mid-session to pause and log what
  pulled you away (tech, another channel, my channel, person, other). A daily tally
  shows what costs you the most.

**Tasks** — add them, check them off, and they move to a **Completed** section
stamped with when you finished and how long they took.

- Unfinished tasks carry over automatically. On a new day they appear under
  **Carried over**, above that day's new additions.
- Every open task is tagged with its age (`2d old`), turning amber at 3 days and
  red at 7, so nothing rots quietly.

**Weekly routines** — click **↻** when adding a task and pick which weekdays it
repeats on. It appears at the top of the list on those days and returns on the next
scheduled day after you complete it.

**Habits** — a tappable 7-day row per habit with streak counts. Today being
unticked doesn't break a streak until the day is over.

**Editing** — hover any task, routine, or habit and click **✎** (or double-click the
text) to fix wording in place. Enter saves, Escape cancels. Click a routine's
**↻ MWF** tag to change which days it runs. History and logged minutes survive
any rename.

**Backups** — **Export backup** downloads a JSON file of everything; **Restore**
reads one back in. Since data is per-browser, this is how you move between
machines or recover after clearing site data. Restoring merges by timestamp, so
the newer version of each record wins and you won't lose recent work.

## Hosting it

It's one file with no build step and no dependencies.

**GitHub Pages:** push this repo, then Settings → Pages → Source: `main` → Save.
Your team opens `https://<user>.github.io/<repo>/` and each gets their own copy.

**Anything else:** drag `index.html` onto [Netlify Drop](https://app.netlify.com/drop),
or serve it from any web server. It also works opened directly from disk.

**Embedding:**

```html
<iframe src="https://<user>.github.io/<repo>/"
        style="width:100%;height:900px;border:0;border-radius:12px"></iframe>
```

## Good to know

Data is per-browser, so a phone and a laptop keep separate lists, and clearing
site data erases it — export a backup if it matters. Private/incognito windows
discard everything on close. The page fetches fonts from Google Fonts; it works
offline apart from those falling back to system faces.

## License

MIT — see [LICENSE](LICENSE).
