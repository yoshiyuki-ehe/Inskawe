CREATE TABLE account (
    id BIGINT GENERATED ALWAYS AS IDENTITY NOT NULL UNIQUE,
    username VARCHAR(50) PRIMARY KEY,
    role VARCHAR(20) NOT NULL DEFAULT 'USER',
    email VARCHAR(255) NOT NULL UNIQUE,
    full_name VARCHAR(100) NOT NULL,
    password VARCHAR(255) NOT NULL,

    CONSTRAINT chk_account_role CHECK (role IN ('USER', 'ADMIN')),
    CONSTRAINT chk_account_username_not_blank CHECK (length(trim(username)) > 0),
    CONSTRAINT chk_account_full_name_not_blank CHECK (length(trim(full_name)) > 0)
);

CREATE TABLE tag (
    id_tag BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nama_tag VARCHAR(50) NOT NULL,

    CONSTRAINT uq_tag_nama_tag UNIQUE (nama_tag),
    CONSTRAINT chk_nama_tag_not_blank CHECK (length(trim(nama_tag)) > 0)
);

CREATE TABLE image (
    id_img BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    image BYTEA NOT NULL,
    deskripsi VARCHAR(120) NOT NULL,

    CONSTRAINT fk_image_account_username FOREIGN KEY (username)
        REFERENCES account (username)
        ON DELETE CASCADE,
    CONSTRAINT chk_deskripsi_not_blank CHECK (length(trim(deskripsi)) > 0)
);

CREATE TABLE image_tag (
    id_img BIGINT NOT NULL,
    id_tag BIGINT NOT NULL,

    CONSTRAINT pk_image_tag PRIMARY KEY (id_img, id_tag),
    CONSTRAINT fk_image_tag_image FOREIGN KEY (id_img)
        REFERENCES image (id_img)
        ON DELETE CASCADE,
    CONSTRAINT fk_image_tag_tag FOREIGN KEY (id_tag)
        REFERENCES tag (id_tag)
        ON DELETE CASCADE
);

CREATE TABLE comment (
    id_comment BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_img BIGINT NOT NULL,
    username VARCHAR(50) NOT NULL,
    isi_comment VARCHAR(255) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_comment_image FOREIGN KEY (id_img)
        REFERENCES image (id_img)
        ON DELETE CASCADE,
    CONSTRAINT fk_comment_account_username FOREIGN KEY (username)
        REFERENCES account (username)
        ON DELETE CASCADE,
    CONSTRAINT chk_isi_comment_not_blank CHECK (length(trim(isi_comment)) > 0)
);