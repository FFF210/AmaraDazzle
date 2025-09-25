package dto;

public class Category {
    private Long categoryId;   // 고유 식별자 (PK, UNIQUE)
    private String name;       // 카테고리명
    private Integer depth;     // 단계 (1:대, 2:중, 3:소)
    private Long parentId;     // 상위 카테고리 ID (FK → category.category_id)

    public Category() {
    }

    public Long getCategoryId() {
        return categoryId;
    }
    public void setCategoryId(Long categoryId) {
        this.categoryId = categoryId;
    }

    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }

    public Integer getDepth() {
        return depth;
    }
    public void setDepth(Integer depth) {
        this.depth = depth;
    }

    public Long getParentId() {
        return parentId;
    }
    public void setParentId(Long parentId) {
        this.parentId = parentId;
    }

    @Override
    public String toString() {
        return "Category [categoryId=" + categoryId +
                ", name=" + name + ", depth=" + depth +
                ", parentId=" + parentId + "]";
    }
}
