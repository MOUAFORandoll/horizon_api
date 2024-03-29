<?php

namespace App\Entity;

use App\Repository\SanctionRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\Serializer\Annotation\Groups;
use ApiPlatform\Core\Annotation\ApiResource;

#[ORM\Entity(repositoryClass: SanctionRepository::class)]
#[ApiResource(
    collectionOperations: [
        'get' => [
            'normalization_context' => [
                'groups' => ['read:sanction']
            ],

        ],
        'post' => [
            'denormalization_context' => [
                'groups' => ['create:sanction']
            ],

        ]

    ]
)]
class Sanction
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    #[Groups([
        "read:sanction"
    ])] private ?int $id = null;

    #[ORM\Column(length: 255)]
    #[Groups([
        "read:sanction-employe",  "read:sanction", "create:sanction"
    ])]   private ?string $libelle = null;

    #[ORM\Column]
    #[Groups([
        "read:sanction-employe",   "read:sanction", "create:sanction"
    ])]
    private ?int $montant = null;

    #[ORM\OneToMany(mappedBy: 'sanction', targetEntity: ListEmployeSanction::class)]
    private Collection $listEmployeSanctions;

    public function __construct()
    {
        $this->listEmployeSanctions = new ArrayCollection();
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

    public function getMontant(): ?int
    {
        return $this->montant;
    }

    public function setMontant(int $montant): static
    {
        $this->montant = $montant;

        return $this;
    }

    /**
     * @return Collection<int, ListEmployeSanction>
     */
    public function getListEmployeSanctions(): Collection
    {
        return $this->listEmployeSanctions;
    }

    public function addListEmployeSanction(ListEmployeSanction $listEmployeSanction): static
    {
        if (!$this->listEmployeSanctions->contains($listEmployeSanction)) {
            $this->listEmployeSanctions->add($listEmployeSanction);
            $listEmployeSanction->setSanction($this);
        }

        return $this;
    }

    public function removeListEmployeSanction(ListEmployeSanction $listEmployeSanction): static
    {
        if ($this->listEmployeSanctions->removeElement($listEmployeSanction)) {
            // set the owning side to null (unless already changed)
            if ($listEmployeSanction->getSanction() === $this) {
                $listEmployeSanction->setSanction(null);
            }
        }

        return $this;
    }
}
