CREATE TABLE courses (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    title VARCHAR(100),
    description VARCHAR(200),
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    is_deleted BOOLEAN
);

CREATE TABLE lessons (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    title VARCHAR(100),
    content TEXT,
    video_link VARCHAR(500),
    position INT,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    is_deleted BOOLEAN,
    course_id INT REFERENCES courses (id)
);

CREATE TABLE modules (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    title VARCHAR(100),
    description VARCHAR(200),
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    is_deleted BOOLEAN
);

CREATE TABLE programs (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    title VARCHAR(100),
    price INT,
    type VARCHAR(100),
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE modules_courses (
    module_id INT REFERENCES modules (id),
    course_id INT REFERENCES  courses (id),
    PRIMARY KEY (module_id, course_id)
);

CREATE TABLE program_modules (
    program_id INT REFERENCES  programs (id),
    module_id INT REFERENCES modules (id),
    PRIMARY KEY (program_id, module_id)
);

CREATE TABLE teaching_groups (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    slack VARCHAR(200),
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TYPE user_role AS ENUM ('Student', 'Teacher', 'Admin');

CREATE TABLE users (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(200),
    email VARCHAR(200),
    role user_role,
    password_hash TEXT,
    teaching_group_id INT REFERENCES teaching_groups (id),
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TYPE enrollment_status AS ENUM ('active', 'pending', 'cancelled', 'completed');

CREATE TABLE enrollments (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_id INT REFERENCES users (id),
    program_id INT REFERENCES programs (id),
    status enrollment_status,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TYPE payment_status AS ENUM ('pending', 'paid', 'failed', 'refunded');

CREATE TABLE payments (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    enrollment_id INT REFERENCES enrollments (id),
    amount INT,
    status payment_status,
    payment_date TIMESTAMP,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TYPE program_completions_status AS ENUM ('active', 'completed', 'pending', 'cancelled');

CREATE TABLE program_completions (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_id INT REFERENCES users (id),
    program_id INT REFERENCES programs (id),
    status program_completions_status,
    begin_at TIMESTAMP,
    end_at TIMESTAMP,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE certificates (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_id INT REFERENCES users (id),
    program_id INT REFERENCES programs (id),
    url VARCHAR(500),
    issue_date TIMESTAMP,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE quizzes (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    lesson_id INT REFERENCES lessons (id),
    title VARCHAR(200),
    context TEXT,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE exercises (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    lesson_id INT REFERENCES lessons (id),
    title VARCHAR(100),
    url VARCHAR(500),
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);


CREATE TABLE discussions (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    lesson_id INT REFERENCES lessons (id),
    content TEXT,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TYPE blog_status AS ENUM ('created', 'in moderation', 'published', 'archived');

CREATE TABLE blogs (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    student_id INT REFERENCES users (id),
    title VARCHAR(200),
    content TEXT,
    status blog_status,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);
