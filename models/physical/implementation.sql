-- Mandatory constraint for program and course
-- A student, -> enrollment -> education class -> program/course
(program_id IS NOT NULL AND course_id IS NULL)
OR
(program_id IS NULL AND course_id IS NOT NULL)


CREATE TABLE "Member" (
  "member_id" INTEGER PRIMARY KEY,
  "member_name" VARCHAR NOT NULL,
  "phone" INTEGER NOT NULL
);