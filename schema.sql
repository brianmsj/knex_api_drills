create table if not exists recipes (
    id serial primary key,
    name text not null,
    description text not null
);

insert into recipes (name, description) values ('Khichidi Kadhi', 'Rice and lentils with a yoghurt gravy');
insert into recipes (name, description) values ('Congee', 'Rice porridge');
insert into recipes (name, description) values ('Kimchi', 'Cabbage and spices');

select * from recipes; 

create table if not exists tags (
    id serial primary key,
    tag text not null
);

insert into tags (tag) values ('rice');
insert into tags (tag) values ('lentils');
insert into tags (tag) values ('cabbage');
insert into tags (tag) values ('spices');

select * from tags; 

create table if not exists recipes_tags (
    recipe_id integer references recipes not null,
    tag_id integer references tags not null,
    primary key (tag_id, recipe_id)
);

insert into recipes_tags (recipe_id, tag_id) values (1, 1);
insert into recipes_tags (recipe_id, tag_id) values (1, 2);
insert into recipes_tags (recipe_id, tag_id) values (2, 1);
insert into recipes_tags (recipe_id, tag_id) values (3, 3);
insert into recipes_tags (recipe_id, tag_id) values (3, 4);

select * from recipes_tags

select * from recipes
join recipes_tags on recipes.id = recipes_tags.recipe_id
join tags on recipes_tags.tag_id = tags.id

create table if not exists steps (
    id serial primary key,
    recipe_id integer references recipes not null,
    step text not null
);

insert into steps (recipe_id, step) values (1, 'Khichidi step 1...');
insert into steps (recipe_id, step) values (1, 'Khichidi step 2...');
insert into steps (recipe_id, step) values (1, 'Khichidi step 3...');

insert into steps (recipe_id, step) values (2, 'Congee step 1...');
insert into steps (recipe_id, step) values (2, 'Congee step 2...');
insert into steps (recipe_id, step) values (2, 'Congee step 3...');

insert into steps (recipe_id, step) values (3, 'Kimchi step 1...');
insert into steps (recipe_id, step) values (3, 'Kimchi step 2...');
insert into steps (recipe_id, step) values (3, 'Kimchi step 3...');

select * from steps

select * from recipes
join steps on recipes.id = steps.recipe_id
order by recipes.name, steps.step


select * from recipes
join recipes_tags on recipes.id = recipes_tags.recipe_id
join tags on recipes_tags.tag_id = tags.id
join steps on recipes.id = steps.recipe_id;

