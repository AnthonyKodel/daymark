-- Daymark cloud sync — run this once in your Supabase project.
-- Dashboard → SQL Editor → New query → paste → Run.
--
-- One row per person, holding that person's whole Daymark state as JSON.
-- Row-level security means a signed-in user can only ever read and write
-- their own row: teammates cannot see each other's tasks, and the public
-- anon key in index.html grants nothing beyond this.

create table if not exists public.daymark_state (
  user_id    uuid primary key references auth.users (id) on delete cascade,
  data       jsonb       not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.daymark_state enable row level security;

-- Postgres has no "create policy if not exists", so drop first to stay re-runnable.
drop policy if exists "read own state"   on public.daymark_state;
drop policy if exists "insert own state" on public.daymark_state;
drop policy if exists "update own state" on public.daymark_state;

create policy "read own state" on public.daymark_state
  for select using (auth.uid() = user_id);

create policy "insert own state" on public.daymark_state
  for insert with check (auth.uid() = user_id);

create policy "update own state" on public.daymark_state
  for update using (auth.uid() = user_id)
           with check (auth.uid() = user_id);
