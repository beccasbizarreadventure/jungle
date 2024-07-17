describe('View product details', () => {
  it('Visits the homepage and clicks on a product', () => {
    cy.visit('http://localhost:3000/');
    cy.get(".products article").first().click();
  });
})