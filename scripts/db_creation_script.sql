CREATE DATABASE oc_pizza;

CREATE USER oc WITH PASSWORD 'OCP10';

ALTER ROLE oc SET client_encoding TO 'utf8';

ALTER ROLE oc SET default_transaction_isolation TO 'read committed';

ALTER ROLE oc SET timezone TO 'Europe/Paris';

GRANT ALL PRIVILEGES ON DATABASE oc_pizza TO oc;

CREATE TABLE public.collaborator_identifiant (
                email VARCHAR(40) NOT NULL,
                password CHAR(64) NOT NULL,
                CONSTRAINT collaborator_identifiant_pk PRIMARY KEY (email)
);
COMMENT ON COLUMN public.collaborator_identifiant.password IS 'SHA-256';


CREATE TABLE public.collaborator_access_level (
                access_level INTEGER NOT NULL,
                CONSTRAINT collaborator_access_level_pk PRIMARY KEY (access_level)
);


CREATE TABLE public.open_hours (
                open_hour CHAR(2) NOT NULL,
                closing_hour CHAR(2) NOT NULL,
                CONSTRAINT open_hours_pk PRIMARY KEY (open_hour, closing_hour)
);


CREATE TABLE public.payment_type (
                type VARCHAR(20) NOT NULL,
                CONSTRAINT payment_type_pk PRIMARY KEY (type)
);


CREATE SEQUENCE public.payment_id_seq;

CREATE TABLE public.payment (
                id INTEGER NOT NULL DEFAULT nextval('public.payment_id_seq'),
                payment_amount NUMERIC(2) NOT NULL,
                payment_type VARCHAR(20) NOT NULL,
                date TIMESTAMP NOT NULL,
                CONSTRAINT payment_pk PRIMARY KEY (id)
);


ALTER SEQUENCE public.payment_id_seq OWNED BY public.payment.id;

CREATE TABLE public.order_state (
                state VARCHAR(30) NOT NULL,
                CONSTRAINT order_state_pk PRIMARY KEY (state)
);


CREATE TABLE public.order_type (
                type VARCHAR(15) NOT NULL,
                CONSTRAINT order_type_pk PRIMARY KEY (type)
);


CREATE SEQUENCE public.cart_id_seq;

CREATE TABLE public.cart (
                id INTEGER NOT NULL DEFAULT nextval('public.cart_id_seq'),
                CONSTRAINT cart_pk PRIMARY KEY (id)
);


ALTER SEQUENCE public.cart_id_seq OWNED BY public.cart.id;

CREATE SEQUENCE public.address_id_seq;

CREATE TABLE public.address (
                id INTEGER NOT NULL DEFAULT nextval('public.address_id_seq'),
                label VARCHAR(30) NOT NULL,
                name VARCHAR(30) NOT NULL,
                phone_number CHAR(10) NOT NULL,
                street_number INTEGER NOT NULL,
                street_name VARCHAR(50) NOT NULL,
                postal_code CHAR(5) NOT NULL,
                city VARCHAR(30) NOT NULL,
                country VARCHAR(30) NOT NULL,
                other_details VARCHAR NOT NULL,
                CONSTRAINT address_pk PRIMARY KEY (id)
);


ALTER SEQUENCE public.address_id_seq OWNED BY public.address.id;

CREATE TABLE public.pizzeria (
                name VARCHAR(30) NOT NULL,
                address_id INTEGER NOT NULL,
                phone_number CHAR(10) NOT NULL,
                email VARCHAR(30) NOT NULL,
                CONSTRAINT pizzeria_pk PRIMARY KEY (name, address_id)
);


CREATE SEQUENCE public.collaborator_id_seq;

CREATE TABLE public.collaborator (
                id INTEGER NOT NULL DEFAULT nextval('public.collaborator_id_seq'),
                lastname VARCHAR(30) NOT NULL,
                firstname VARCHAR(30) NOT NULL,
                social_id VARCHAR NOT NULL,
                phone_number CHAR(10) NOT NULL,
                email VARCHAR(30) NOT NULL,
                emergency_contact VARCHAR(80),
                rib CHAR(27) NOT NULL,
                pizzeria_address_id INTEGER NOT NULL,
                pizzeria_name VARCHAR(30) NOT NULL,
                collaborator_access_level INTEGER NOT NULL,
                collaborator_identifiant_email VARCHAR(40) NOT NULL,
                address_id INTEGER NOT NULL,
                CONSTRAINT collaborator_pk PRIMARY KEY (id)
);


ALTER SEQUENCE public.collaborator_id_seq OWNED BY public.collaborator.id;

CREATE TABLE public.open_hours_list (
                pizzeria_name VARCHAR(30) NOT NULL,
                address_id INTEGER NOT NULL,
                open_hour CHAR(2) NOT NULL,
                closing_hour CHAR(2) NOT NULL,
                CONSTRAINT open_hours_list_pk PRIMARY KEY (pizzeria_name, address_id, open_hour, closing_hour)
);


CREATE TABLE public.identifiant (
                email VARCHAR(40) NOT NULL,
                password CHAR(64) NOT NULL,
                CONSTRAINT identifiant_pk PRIMARY KEY (email)
);
COMMENT ON COLUMN public.identifiant.password IS 'SHA-256';


CREATE TABLE public.client (
                identifiant_email VARCHAR(40) NOT NULL,
                lastname VARCHAR(30) NOT NULL,
                firstname VARCHAR(30) NOT NULL,
                phone_number CHAR(10) NOT NULL,
                pizzeria_name VARCHAR(30) NOT NULL,
                pizzeria_address_id INTEGER NOT NULL,
                CONSTRAINT client_pk PRIMARY KEY (identifiant_email)
);


CREATE TABLE public.address_list (
                identifiant_email VARCHAR(40) NOT NULL,
                address_id INTEGER NOT NULL,
                CONSTRAINT address_list_pk PRIMARY KEY (identifiant_email, address_id)
);


CREATE SEQUENCE public.ordering_order_number_seq;

CREATE TABLE public.ordering (
                order_number INTEGER NOT NULL DEFAULT nextval('public.ordering_order_number_seq'),
                date TIMESTAMP NOT NULL,
                order_amount NUMERIC(2) NOT NULL,
                order_type VARCHAR(15) NOT NULL,
                order_state VARCHAR(30) NOT NULL,
                cart_id INTEGER NOT NULL,
                payment_id INTEGER NOT NULL,
                identifiant_email VARCHAR(40) NOT NULL,
                pizzeria_name VARCHAR(30) NOT NULL,
                pizzeria_address_id INTEGER NOT NULL,
                CONSTRAINT ordering_pk PRIMARY KEY (order_number)
);


ALTER SEQUENCE public.ordering_order_number_seq OWNED BY public.ordering.order_number;

CREATE SEQUENCE public.review_id_seq;

CREATE TABLE public.review (
                id INTEGER NOT NULL DEFAULT nextval('public.review_id_seq'),
                date TIMESTAMP NOT NULL,
                review VARCHAR(2000) NOT NULL,
                rating NUMERIC(1) NOT NULL,
                client_identifiant_email VARCHAR(40) NOT NULL,
                pizzeria_name VARCHAR(30) NOT NULL,
                address_id INTEGER NOT NULL,
                CONSTRAINT review_pk PRIMARY KEY (id)
);


ALTER SEQUENCE public.review_id_seq OWNED BY public.review.id;

CREATE TABLE public.performance (
                date DATE NOT NULL,
                pizzeria_name VARCHAR(30) NOT NULL,
                address_id INTEGER NOT NULL,
                turnover NUMERIC(10,2) NOT NULL,
                CONSTRAINT performance_pk PRIMARY KEY (date, pizzeria_name, address_id)
);


CREATE TABLE public.meal (
                name VARCHAR(35) NOT NULL,
                price NUMERIC(2) NOT NULL,
                size VARCHAR,
                CONSTRAINT meal_pk PRIMARY KEY (name)
);


CREATE SEQUENCE public.item_id_seq;

CREATE TABLE public.item (
                id INTEGER NOT NULL DEFAULT nextval('public.item_id_seq'),
                quantity INTEGER DEFAULT 1 NOT NULL,
                other_informations VARCHAR(30),
                meal_name VARCHAR(35) NOT NULL,
                CONSTRAINT item_pk PRIMARY KEY (id)
);


ALTER SEQUENCE public.item_id_seq OWNED BY public.item.id;

CREATE TABLE public.item_list (
                cart_id INTEGER NOT NULL,
                item_id INTEGER NOT NULL,
                CONSTRAINT item_list_pk PRIMARY KEY (cart_id, item_id)
);


CREATE TABLE public.stock (
                name VARCHAR(30) NOT NULL,
                quantity NUMERIC(3) DEFAULT 1.000 NOT NULL,
                unit_type VARCHAR(5) NOT NULL,
                vat_rate NUMERIC DEFAULT 5.5 NOT NULL,
                minimum_stock NUMERIC NOT NULL,
                CONSTRAINT stock_pk PRIMARY KEY (name)
);


CREATE TABLE public.recipe (
                meal_name VARCHAR(35) NOT NULL,
                stock_name VARCHAR(30) NOT NULL,
                CONSTRAINT recipe_pk PRIMARY KEY (meal_name, stock_name)
);
COMMENT ON TABLE public.recipe IS 'composition classe';


ALTER TABLE public.collaborator ADD CONSTRAINT collaborator_identifiant_collaborator_fk
FOREIGN KEY (collaborator_identifiant_email)
REFERENCES public.collaborator_identifiant (email)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.collaborator ADD CONSTRAINT collaborator_access_level_collaborator_fk
FOREIGN KEY (collaborator_access_level)
REFERENCES public.collaborator_access_level (access_level)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.open_hours_list ADD CONSTRAINT open_hours_open_hours_list_fk
FOREIGN KEY (open_hour, closing_hour)
REFERENCES public.open_hours (open_hour, closing_hour)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.payment ADD CONSTRAINT payment_type_payment_fk
FOREIGN KEY (payment_type)
REFERENCES public.payment_type (type)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.ordering ADD CONSTRAINT payment_order_fk
FOREIGN KEY (payment_id)
REFERENCES public.payment (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.ordering ADD CONSTRAINT order_state_order_fk
FOREIGN KEY (order_state)
REFERENCES public.order_state (state)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.ordering ADD CONSTRAINT order_type_order_fk
FOREIGN KEY (order_type)
REFERENCES public.order_type (type)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.item_list ADD CONSTRAINT cart_item_list_fk
FOREIGN KEY (cart_id)
REFERENCES public.cart (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.ordering ADD CONSTRAINT cart_order_fk
FOREIGN KEY (cart_id)
REFERENCES public.cart (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.pizzeria ADD CONSTRAINT address_pizzeria_fk
FOREIGN KEY (address_id)
REFERENCES public.address (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.address_list ADD CONSTRAINT address_address_list_fk
FOREIGN KEY (address_id)
REFERENCES public.address (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.collaborator ADD CONSTRAINT address_collaborator_fk
FOREIGN KEY (address_id)
REFERENCES public.address (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.open_hours_list ADD CONSTRAINT pizzeria_open_hours_list_fk
FOREIGN KEY (pizzeria_name, address_id)
REFERENCES public.pizzeria (name, address_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.performance ADD CONSTRAINT pizzeria_performance_fk
FOREIGN KEY (pizzeria_name, address_id)
REFERENCES public.pizzeria (name, address_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.review ADD CONSTRAINT pizzeria_review_fk
FOREIGN KEY (pizzeria_name, address_id)
REFERENCES public.pizzeria (name, address_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.ordering ADD CONSTRAINT pizzeria_order_fk
FOREIGN KEY (pizzeria_name, pizzeria_address_id)
REFERENCES public.pizzeria (name, address_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.client ADD CONSTRAINT pizzeria_client_fk
FOREIGN KEY (pizzeria_name, pizzeria_address_id)
REFERENCES public.pizzeria (name, address_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.collaborator ADD CONSTRAINT pizzeria_collaborator_fk
FOREIGN KEY (pizzeria_name, pizzeria_address_id)
REFERENCES public.pizzeria (name, address_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.client ADD CONSTRAINT identifiant_client_fk
FOREIGN KEY (identifiant_email)
REFERENCES public.identifiant (email)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.address_list ADD CONSTRAINT client_address_list_fk
FOREIGN KEY (identifiant_email)
REFERENCES public.client (identifiant_email)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.ordering ADD CONSTRAINT client_order_fk
FOREIGN KEY (identifiant_email)
REFERENCES public.client (identifiant_email)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.review ADD CONSTRAINT client_review_fk
FOREIGN KEY (client_identifiant_email)
REFERENCES public.client (identifiant_email)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.recipe ADD CONSTRAINT meal_recette_fk
FOREIGN KEY (meal_name)
REFERENCES public.meal (name)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.item ADD CONSTRAINT meal_item_fk
FOREIGN KEY (meal_name)
REFERENCES public.meal (name)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.item_list ADD CONSTRAINT item_item_list_fk
FOREIGN KEY (item_id)
REFERENCES public.item (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.recipe ADD CONSTRAINT stock_recette_fk
FOREIGN KEY (stock_name)
REFERENCES public.stock (name)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;