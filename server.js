const bodyParser = require('body-parser');
const express = require('express');



const knex = require('knex')({
    client: 'pg',
    connection: {
        database: 'recipify'
    },
});

const app = express();
app.use(bodyParser.json());

app.get('/recipes', (req, res) => {
    knex.select('name', 'description', 'step')
    .join('steps', 'steps.recipe_id', 'recipes.id')
    .from('recipes')
    .then(results => {
        res.json(results)
    })
    .catch(err => {
        res.send(err)
    });
});

// Bonus
app.get('/recipes/:id', (req, res) => {
    knex.select('description').from('recipes').where({
        id: req.params.id
    }).then(recipes => {
        console.log(recipes[0]);
        // hydrate
        res.json({ msg: 'get' })
    });
});

app.post('/recipes', (req, res) => {
    // dehydrate
    const newRecipe = req.body;

    knex.insert({
        name: req.body.name,
        description: req.body.description
    })
    .returning('id')
    .into('recipes')
    .then(recipe_ids => {
        console.log(recipe_ids);
        req.body.id = recipe_ids[0];
        const newSteps = req.body.steps.map(step => ({recipe_id: req.body.id,step}));
        return knex.insert(newSteps)
          .into('steps');
    })
    .then(results => {
      console.log(results);
      res.status(201).json(req.body)
    })
});

app.listen(8080, () => {
    process.stdout.write('\033c');
    console.log(`Your app is listening on port 8080`);
});
