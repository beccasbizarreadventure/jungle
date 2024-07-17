describe('Add to cart', () => {
  it('Add a product to the cart and updates the cart count', () => {
    cy.visit('http://localhost:3000/')
    cy.get(".products article form")
    cy.get("button").contains("Add").first().click()
    cy.get('a.nav-link').contains("My Cart (1)")
  });
})