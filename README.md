Algolia Client for Elm
======================
![Elm Logo](https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQFaAAWSMsdUMAGZuNCogzG4RCmlf0TPFUwGCarfhnYPSGlHU4n-_exKqNmsQ)

This is an *experimental*, *work in progress* implementation of Algolia Client written 100% in [Elm](http://elm-lang.org/).

**Please don't use this in real life.** 🙏

Setup
-----

1. `npm install -g elm`
2. `elm-package install`
3. `elm reactor`

Then open `http://localhost:8000/App.elm` in your browser.

Coverage
--------
### Indexes Api
- [x] Query an index
- [x] Query an index (alternative)
- [ ] Query multiple indexes
- [ ] Delete an index
- [ ] Clear index
- [ ] Add an object without ID
- [ ] Add/Update an object by ID
- [ ] Partially update an object
- [ ] Get an object
- [ ] Retrieve Several Objects
- [ ] Delete an object by ID
- [ ] Batch write operations
- [ ] Browse all index content
- [ ] Get index settings
- [ ] Change index settings
- [ ] Copy/Move an index
- [ ] Get task status
- [ ] Add an index specific API key
- [ ] Update an index specific API key
- [ ] List index specific API Keys
- [ ] List index specific API Keys for all indexes
- [ ] Get the rights of an index specific API key
- [ ] Delete an index specific API key

### Synonyms API
- [ ] Create/update one synonym
- [ ] Create/update multiple synonyms
- [ ] Get one synonyms set
- [ ] Delete one synonyms set
- [ ] Delete all synonyms
- [ ] Search synonyms

### Keys API
- [ ] Add a global API key
- [ ] Update a global API key
- [ ] List global API Keys
- [ ] Get the rights of a global API key
- [ ] Delete a global API key

### Logs API
- [ ] Get last logs
