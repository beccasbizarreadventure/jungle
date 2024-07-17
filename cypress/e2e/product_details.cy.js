describe('View product details', () => {
  it('Visits the homepage and finds 2 products on the page', () => {
    cy.visit('http://localhost:3000/');
    cy.get(".products article").first().click();
  });
})