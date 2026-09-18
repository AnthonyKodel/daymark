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

## Cloud sync (optional, free)

Out of the box the app stores data in each visitor's own browser. That is
private and needs no setup, but it does not follow anyone between devices, and
Safari discards it after about a week of not visiting. To give the team real
accounts with data that syncs everywhere and survives a cleared browser, wire
it to [Supabase](https://supabase.com) — the free tier is ample for a team.

1. Create a project at [supabase.com](https://supabase.com) (free, no card).
2. In the dashboard open **SQL Editor → New query**, paste all of
   [`supabase-setup.sql`](supabase-setup.sql), and hit **Run**. That creates one
   table and the security rules that keep each person's row private.
3. Go to **Project Settings → API** and copy the **Project URL** and the
   **anon / public** key.
4. Paste both near the top of `index.html`, replacing the `PASTE_...`
   placeholders, then redeploy.
5. Under **Authentication → Providers → Email**, turn **Confirm email** off if
   you want teammates to sign up and start immediately. Leave it on and they
   will each get a confirmation link first — Supabase's built-in email sender is
   rate-limited to a few messages an hour, so for a team, off is simpler.

Everyone then opens the same URL, creates an account with an email and
password, and gets their own private dashboard on every device they sign in on.

**Is it safe to publish those two keys?** Yes. The anon key is designed to ship
in client code; it grants only what the row-level-security rules in the SQL
allow, which is "read and write your own row, nothing else." Never paste the
`service_role` key into the page — that one bypasses those rules.

Without the keys filled in, nothing changes: no sign-in screen appears and the
app stays browser-local.

## Hosting it

It's one file with no build step and no dependencies.

**GitHub Pages:** this repo ships a deploy workflow, so publishing is one setting:

1. Push the repo to GitHub.
2. **Settings → Pages → Source: GitHub Actions** (*not* "Deploy from a branch" —
   the included workflow does the publishing).
3. The first deploy runs automatically. Watch it under the **Actions** tab; the
   live URL appears on the `deploy` job when it finishes.

After that, every push to `main` redeploys within about a minute. You can also
trigger one by hand from **Actions → Deploy to GitHub Pages → Run workflow**. A
quick sanity check runs before each deploy, so a half-saved `index.html` fails
the build instead of reaching your team.

Your team opens `https://<user>.github.io/<repo>/` and each gets their own copy.

> Pages on a **private** repo requires a paid GitHub plan. On the free tier the
> repo must be public — the source becomes visible, but no one's data ever does,
> since nothing is stored outside each person's own browser.

**Netlify:** drag `index.html` onto [Netlify Drop](https://app.netlify.com/drop) for an
instant URL, or connect the repo for auto-deploys on every push. Netlify hosts
private projects free, so the source need not be public.

**Anything else:** Cloudflare Pages, Vercel, or any plain web server. It also
works opened directly from disk.

**Embedding:**

```html
<iframe src="https://<user>.github.io/<repo>/"
        style="width:100%;height:900px;border:0;border-radius:12px"></iframe>
```

## Good to know

**Without cloud sync,** data is per-browser: a phone and a laptop keep separate
lists, clearing site data erases it, private windows discard everything on
close, and Safari drops it after roughly a week of not visiting. Export a backup
if any of that matters — or set up cloud sync above, which fixes all of it.

**With cloud sync,** each person signs in and their data lives in your Supabase
project, syncing across devices. Signing out clears the data from that browser,
so a shared machine stays clean.

The page loads fonts from Google Fonts and, when sync is on, the Supabase
library from a CDN; it still works offline, with system fonts and local saves
that upload when the connection returns.

## License

MIT — see [LICENSE](LICENSE).
