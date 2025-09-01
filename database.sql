CREATE TABLE courses (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100),
    description VARCHAR(200),
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    is_deleted BOOLEAN
);

CREATE TABLE lessons (
    id SERIAL PRIMARY KEY,
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
    id SERIAL PRIMARY KEY,
    title VARCHAR(100),
    description VARCHAR(200),
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    is_deleted BOOLEAN
);

CREATE TABLE programs (
    id SERIAL PRIMARY KEY,
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
    module_id INT REFERENCES modules (id)
    PRIMARY KEY (program_id, course_id)
);