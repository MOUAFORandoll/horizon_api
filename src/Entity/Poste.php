<?php

namespace App\Entity;

use App\Repository\PosteRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\DBAL\Types\Types;
use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\Serializer\Annotation\Groups;
use ApiPlatform\Core\Annotation\ApiResource;

#[ORM\Entity(repositoryClass: PosteRepository::class)]
#[ApiResource(
    collectionOperations: [
        'get' => [
            'normalization_context' => [
                'groups' => ['read:poste']
            ],

        ],
        'post' => [
            'denormalization_context' => [
                'groups' => ['create:poste']
            ],

        ]

    ]
)]
class Poste
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    #[Groups([
        "read:poste"
    ])]
    private ?int $id = null;

    #[ORM\Column(length: 255)]
    #[Groups([
        "read:poste", "create:poste", 'read:poste-employe'
    ])]
    private ?string $libelle = null;

    #[Groups([
        "read:poste",
    ])]
    #[ORM\OneToMany(mappedBy: 'poste', targetEntity: ListEmployePoste::class)]
    private Collection $listEmployePostes;

    public function __construct()
    {
        $this->listEmployePostes = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getLibelle(): ?string
    {
        return $this->libelle;
    }

    public function setLibelle(string $libelle): static
    {
        $this->libelle = $libelle;

        return $this;
    }


    /**
     * @return Collection<int, ListEmployePoste>
     */
    public function getListEmployePostes(): Collection
    {
        return $this->listEmployePostes;
    }

    public function addListEmployePoste(ListEmployePoste $listEmployePoste): static
    {
        if (!$this->listEmployePostes->contains($listEmployePoste)) {
            $this->listEmployePostes->add($listEmployePoste);
            $listEmployePoste->setPoste($this);
        }

        return $this;
    }

    public function removeListEmployePoste(ListEmployePoste $listEmployePoste): static
    {
        if ($this->listEmployePostes->removeElement($listEmployePoste)) {
            // set the owning side to null (unless already changed)
            if ($listEmployePoste->getPoste() === $this) {
                $listEmployePoste->setPoste(null);
            }
        }

        return $this;
    }
}
