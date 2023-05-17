export const isInvalidId = (id) => {
    return Number.isNaN(parseInt(id, 10));
}