describe('Home Page', () => {
  it('should load successfully and have the correct heading', () => {
    cy.visit('/');
    cy.get('h1').should('exist');
  });
});
