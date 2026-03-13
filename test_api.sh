#!/usr/bin/env bash

BASE_URL="http://localhost:8080/api"
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${YELLOW}=== 1. USERS ===${NC}"

echo -e "${GREEN}POST /api/users${NC}"
USER=$(curl -s -X POST "$BASE_URL/users" \
  -H "Content-Type: application/json" \
  -d '{"email": "test@mail.com", "password": "123", "role": "USER"}')
echo $USER | jq .
USER_ID=$(echo $USER | jq -r '.id')

echo -e "${GREEN}GET /api/users${NC}"
curl -s "$BASE_URL/users" | jq .

echo -e "${GREEN}GET /api/users/$USER_ID${NC}"
curl -s "$BASE_URL/users/$USER_ID" | jq .

echo -e "${BLUE}PUT /api/users/$USER_ID${NC}"
curl -s -X PUT "$BASE_URL/users/$USER_ID" \
  -H "Content-Type: application/json" \
  -d '{"email": "updated@mail.com", "password": "123", "role": "ADMIN"}' | jq .


echo -e "${YELLOW}=== 2. CATEGORIES ===${NC}"

echo -e "${GREEN}POST /api/categories${NC}"
CATEGORY=$(curl -s -X POST "$BASE_URL/categories" \
  -H "Content-Type: application/json" \
  -d '{"name": "Electronics"}')
echo $CATEGORY | jq .
CATEGORY_ID=$(echo $CATEGORY | jq -r '.id')

echo -e "${GREEN}GET /api/categories${NC}"
curl -s "$BASE_URL/categories" | jq .

echo -e "${GREEN}GET /api/categories/$CATEGORY_ID${NC}"
curl -s "$BASE_URL/categories/$CATEGORY_ID" | jq .

echo -e "${BLUE}PUT /api/categories/$CATEGORY_ID${NC}"
curl -s -X PUT "$BASE_URL/categories/$CATEGORY_ID" \
  -H "Content-Type: application/json" \
  -d '{"name": "Phones & Tablets"}' | jq .


echo -e "${YELLOW}=== 3. PRODUCTS ===${NC}"

echo -e "${GREEN}POST /api/products${NC}"
PRODUCT=$(curl -s -X POST "$BASE_URL/products" \
  -H "Content-Type: application/json" \
  -d "{\"name\": \"Phone\", \"description\": \"Cool phone\", \"price\": 999.99, \"category\": {\"id\": $CATEGORY_ID}}")
echo $PRODUCT | jq .
PRODUCT_ID=$(echo $PRODUCT | jq -r '.id')

echo -e "${GREEN}GET /api/products${NC}"
curl -s "$BASE_URL/products" | jq .

echo -e "${GREEN}GET /api/products/$PRODUCT_ID${NC}"
curl -s "$BASE_URL/products/$PRODUCT_ID" | jq .

echo -e "${BLUE}PUT /api/products/$PRODUCT_ID${NC}"
curl -s -X PUT "$BASE_URL/products/$PRODUCT_ID" \
  -H "Content-Type: application/json" \
  -d "{\"name\": \"iPhone 15\", \"description\": \"Very cool phone\", \"price\": 1299.99, \"category\": {\"id\": $CATEGORY_ID}}" | jq .


echo -e "${YELLOW}=== 4. ORDERS ===${NC}"

echo -e "${GREEN}POST /api/orders${NC}"
ORDER=$(curl -s -X POST "$BASE_URL/orders" \
  -H "Content-Type: application/json" \
  -d "{\"status\": \"NEW\", \"user\": {\"id\": $USER_ID}}")
echo $ORDER | jq .
ORDER_ID=$(echo $ORDER | jq -r '.id')

echo -e "${GREEN}GET /api/orders${NC}"
curl -s "$BASE_URL/orders" | jq .

echo -e "${GREEN}GET /api/orders/$ORDER_ID${NC}"
curl -s "$BASE_URL/orders/$ORDER_ID" | jq .

echo -e "${BLUE}PUT /api/orders/$ORDER_ID${NC}"
curl -s -X PUT "$BASE_URL/orders/$ORDER_ID" \
  -H "Content-Type: application/json" \
  -d '{"status": "CONFIRMED"}' | jq .


echo -e "${YELLOW}=== 5. ORDER ITEMS ===${NC}"

echo -e "${GREEN}POST /api/orders/$ORDER_ID/items${NC}"
curl -s -X POST "$BASE_URL/orders/$ORDER_ID/items" \
  -H "Content-Type: application/json" \
  -d "{\"product\": {\"id\": $PRODUCT_ID}, \"quantity\": 2, \"price\": 999.99}" | jq .


echo -e "${YELLOW}=== 6. DELETE (правильный порядок) ===${NC}"

echo -e "${RED}DELETE /api/orders/$ORDER_ID${NC}"
curl -s -X DELETE "$BASE_URL/orders/$ORDER_ID"
echo " -> order $ORDER_ID deleted"

echo -e "${RED}DELETE /api/products/$PRODUCT_ID${NC}"
curl -s -X DELETE "$BASE_URL/products/$PRODUCT_ID"
echo " -> product $PRODUCT_ID deleted"

echo -e "${RED}DELETE /api/categories/$CATEGORY_ID${NC}"
curl -s -X DELETE "$BASE_URL/categories/$CATEGORY_ID"
echo " -> category $CATEGORY_ID deleted"

echo -e "${RED}DELETE /api/users/$USER_ID${NC}"
curl -s -X DELETE "$BASE_URL/users/$USER_ID"
echo " -> user $USER_ID deleted"

echo -e "${YELLOW}=== DONE ===${NC}"
